//"Write a Trigger to Stop creating any more Plan records with location 'A' 
//if we have Travel Hours more than 100 for any specific location 'A'. Example 
//If total hours of all the Plans for A is 90 and B is 70 and C is 100 and 
// a new Plan is getting created with A hours 5. Trigger should not stop as total hours will become 95 
//a new Plan is getting created with B hours 45. Trigger should stop as total hours will become 105."

public class PlanTriggerHelper {
    
    public static void stopCreatingPlans(List<Plan__C> planList){
        List<String> planLocation=new List<String>();
        List<Decimal> planHour=new list<Decimal>();
        
        
        
        Map<ID,Plan__c> planMap=new Map<ID,Plan__c>([select id,Travel_Location__c,Travel_Hours__c from Plan__c  limit 452]);
        System.debug('Plan Map recieved '+planMap);
        
        Map<String,Decimal> planMap2=new Map<String,Decimal>();
        
        
        //CALCULATING TOTAL HOURS BY SPECIFIC LOCATION
        for(Plan__c plan:planMap.values())
        {
            if(!planMap2.containsKey(plan.Travel_Location__c)){
                planMap2.put(plan.Travel_Location__c,plan.Travel_Hours__c);
            }
            else
            {
                Decimal hours = planMap2.get(plan.Travel_Location__c) +plan.Travel_Hours__c;
                planMap2.put(plan.Travel_Location__c,hours);
            }
        }
        
        
        
        System.debug('Plan 2 Map '+planMap2.values());
        
        for(Plan__c plan:planList)
        {
            Decimal hour=0;
            Decimal TotalHours=0;
            if(plan.Travel_Location__c !=NULL)
            {
                if(planMap2.get(plan.Travel_Location__c)!=NULL)
                hour=planMap2.get(plan.Travel_Location__c);
                System.debug('Total travel hours by the specific location :: '+plan.Travel_Location__c);
                if(plan.Travel_Hours__c!=NULL)
                TotalHours=hour + plan.Travel_Hours__c;
                System.debug('Total hours now if this is added  ::'+totalHours);
                
                if(TotalHours>100){
                    plan.addError('Can\'t Plan this location it has already exceeded the maximum limit of 100 hours by :: '+(100-totalHours));
                }
            }
        }
        
    }
    
}