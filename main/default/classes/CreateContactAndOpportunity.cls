/*
*  Write a script to create Contact and Opportunity on All accounts where account status is Active."
*/ 

public class CreateContactAndOpportunity {
    
    public static void createConAndOpp()
    {
        try{
            
            List<contact> conList=new List<Contact>();
            List<Opportunity> opporList=new List<Opportunity>();
            
            for(Account account:[SELECT ID FROM ACCOUNT WHERE Status__c='Active' Limit 1500])
            {
                System.debug('Account '+account.Id);
                Contact contact=CreateContact.createContact('Created',account.Id);
                conList.add(contact);
                Opportunity opporutunity=CreateOpportunity.createOpportunity('Opportunity Created ',account.Id);
                opporList.add(opporutunity);
                
            }
            System.debug('contact list to be inserted '+conList);
            if(!conList.isEmpty())
                insert conList;
            
            System.debug('opportunity list to be inserted '+opporList);
            if(!opporList.isEmpty()){
                insert opporlist;
            }
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
    }
    
       
}