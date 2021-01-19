/*
* Write a Script to get all the Accounts having more than 2 Oppotunity Line Items in their Opportunity.
*/ 

public class GetAccountMoreThan {
    public static void getAccount()
    {
        
        try
        {
            Map<id,Opportunity> oppMap=new Map<id,Opportunity>([select id,Name,AccountID,(select id from opportunityLineItems) from Opportunity where AccountID in 
                                                                (select id from Account) limit 1500]);
            system.debug('OppMap   >>>> '+oppMap);
            
            set<ID> accID=new set<ID>();
            for(Opportunity opportunity:oppMap.values()){
                
                if(opportunity.opportunityLineItems.size()>2){
                    accID.add(opportunity.AccountId);
                }
            }
            
            Map<ID,Account> accMap=new Map<ID,Account>([select id,Name from Account where id in:accID]);
            system.debug('Accounts having more than 2 opportunity line items '+accMap);
            
            
            
            
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
    }
    
    
}