/*"""On Product Object : Create a picklist field - """"Rating""""  with Field Values :  """"1 Star"""", """"2 Star"""" , 3 Star""""
Write a Trigger on Opportunity Line Item such that : The picklist value with highest number of occurences gets populated in the """"
for example : Account A has 6 Opportunity Line Items and """"2 Star"""" occurs the most in all the line items so the account Rating field should
autopopulate """"Warm"""".""" 
*/

public class OpportunityLineItemHelper {
    
    // I HAVE TO COLLECT THE PARENT ACCOUNT AND THEN EXPLORE ITS ALL LINE ITEMS, BASED ON THE MOST OCCURENCES 
    // OF PRODUCT RATINGS CHANGE ACCOUNT RATING.
    
    public static void setRating(Map<ID,OpportunityLineItem> oliMap){
        //GET ID OF THE INSERTED OR UPDATED LINE ITEMS
        try{
            Set<ID> oliID=oliMap.keySet();
            
            System.debug('OLI Map 1 ::'+oliMap);
            
            /**********************************************************/
            
            
            Map<ID,Opportunity> opportunityMap=new Map<ID,Opportunity>([SELECT AccountID from Opportunity where id IN (select OpportunityID from OpportunityLineItem where id in :oliID) limit 500]);
            
            System.debug('Opportunity Map recieved '+opportunityMap);
            Set<ID> opporID=opportunityMap.keySet();
            
            
            Map<ID,Account> accountMap=new Map<ID,Account>([Select Id from Account where ID in (select AccountId from Opportunity where id IN :opporID ) limit 500]);
            System.debug('Account ID list gathered '+accountMap);
            
            Set<ID> accID=accountMap.keySet();
            
            Map<ID,Opportunity> opportunityMap2=new Map<ID,Opportunity>([select id,Name,Account.Rating,AccountID from Opportunity where AccountID IN:accID limit 500]);
            
            set<ID> opporID2=opportunityMap2.keySet();
            
            Map<ID,OpportunityLineItem> oliMap2=new Map<ID,OpportunityLineItem>([select id,Product2.Rating__C,Product2.Name from OpportunityLineItem where OpportunityID IN :opporID2 limit 500]);
            /**********************************************************/
            
            // Map<ID,OpportunityLineItem> oliMap3=new Map<ID,OpportunityLineItem>([select id from OpportunityLineItem where Opportunity.AccountId in :acID limit 500]);
            
            /***********************************************************/
            System.debug('Oli map 2 ::'+oliMap2);
            Integer star1=0;
            Integer star2=0;
            Integer star3=0;
            
            for(OpportunityLineItem oli:oliMap2.values()){
                System.debug('Product 2 Name '+oli.Product2.Name);
                
                if(oli.Product2.Rating__C=='1 Star'){
                    star1++;
                }
                else if (oli.Product2.Rating__C=='2 Star'){
                    star2++;
                }
                else if (oli.Product2.Rating__C=='3 Star'){
                    star3++;
                }
            }
            System.debug('1 Star = '+Star1 + ', 2 Star = '+Star2 +' , 3 Star = '+Star3);
            
            Account acc;
            for(Opportunity opportunity:opportunityMap2.values())
                
            {
                acc=new Account(id=opportunity.AccountId);
                
                System.debug('inside opploop');
                if(star1>star2 && star1 > star3)
                {
                    acc.Rating='Cold';
                    System.debug('cold');
                }
                else  if(star2>star1 && star2> star3)
                {
                    
                    acc.Rating='Warm';
                    System.debug('warm');
                    
                }
                else if(Star3>star1 && star3>Star2){
                    acc.Rating='Hot';
                    System.debug('Hot');
                    
                }
                else
                {
                    System.debug('Warmmm');
                    acc.Rating='Warm';
                    // acc.NumberOfEmployees=20;
                    
                }
                
                
            }
            update acc;
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.Debug(e.getMessage());}
        
        
    }
    //"1.Create a custom field in Account( named as Number of Line Items) and whenever the
    // Opportunity line item is inserted under the Opportunity of the Account,
    //increment the Number of Line Items field that you've created above by one on the corresponding Account."
    
    public static void incrementLineItems(map<id,OpportunityLineItem> LineItemMap){
        Set<ID> LineItemID=LineItemMap.keySet();
        
        //			GET THE PARENT OPPORTUNITY
        Map<id,Opportunity> opportunityMap=new Map<id,Opportunity>([select id,AccountId from Opportunity where ID in (select OpportunityId from OpportunityLineItem where ID in:LineItemID) limit 151]);
        System.debug('Opportunity Map recieved in Opportunity Line Item Helper '); 
        System.debug(+opportunityMap);
        Set<ID> oppID =opportunityMap.keySet();
        
        //			NOW GET THE PARENT ACCOUNT
        
        
        Map<ID,Account> accountMap=new Map<ID,Account>([Select Id from Account where ID in (select AccountId from Opportunity where id IN :oppID ) limit 500]);
        System.debug('Account ID list gathered '+accountMap);
        
        Set<ID> accID=accountMap.keySet();
        
        Map<ID,Opportunity> opportunityMap2=new Map<ID,Opportunity>([select id,Name,AccountID,(select id from OpportunityLineItems) from Opportunity where AccountID IN:accID limit 500]);
        System.debug('Opportunity Map 22222222 recieved in Opportunity Line Item Helper '); 
        System.debug(+opportunityMap2);

        set<ID> opporID2=opportunityMap2.keySet();
        
        /**********************************************************/
        
        for(Account acc:accountMap.values())
        {
            Integer totalLineItems=0;
            for(Opportunity opp:opportunityMap2.values())
            {
                totalLineItems  +=opp.OpportunityLineItems.size();              
            }
			System.debug('total line items belong to account ::'+acc+', totalLineItems :: '+totalLineItems);            
            acc.Number_of_Line_Items__c=totalLineItems;

            
        }
        
        if(!accountMap.isEmpty()){
            update accountMap.values();
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
}