//Write a script to get the total hours of all the Plans
//record having Multipicklist A or F selected only or with other values."
// Plan__c  Travel_Hours__c Travel_Location__c

public class PlanTravelHours {
    
    public static void totalHours(){
        
        Map<ID,Plan__c> plans=new Map<ID,Plan__c>([select Travel_Hours__c,Travel_Location__c from Plan__c limit 4500]);
        System.debug('Plans recieved '+plans);
        
        try{
            Decimal hours=0;
            
            for(Plan__c plan:plans.values())
            {
                
                System.debug('Plan '+plan);
                System.debug('Travel Location '+plan.Travel_Location__c);
                if(plan.Travel_Location__c==NULL){
                    plan.Travel_Location__c='';
                }
                if(plan.Travel_Location__c.contains('A') || plan.Travel_Location__c.contains('F'))
                {
                    System.debug(' Travel hours >>>>>> '+plan.Travel_Hours__c);
                    hours +=plan.Travel_Hours__c;
                }
            }
            System.debug('total hours of all the Plans :: '+hours);
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
        
        
    }
}