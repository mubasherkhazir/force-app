@isTest
public class TestClassLeadTriggerHelper {
    
    @isTest
    public static void testCreateOpp(){
        Pricebook2 pbook2=new Pricebook2();
        pbook2.Id=Test.getStandardPricebookId();
        pbook2.IsActive=true;
        update pbook2;
        
        Lead lead=new Lead();
        lead.LastName='my lead';
        lead.Status='Working - Contacted';
        lead.Company='my company';
        insert lead;
        
        Product2 prod=new Product2();
        prod.Name='Choclate';
        prod.Lead__c=lead.Id;
        insert prod;
        
        
        
       
        
        lead lead2=[select id from lead where lastName='my lead' limit 1];
        system.assert(lead2 != NULL);
        
        lead2.Status='Closed - Converted';
        update lead2 ;
           
    }
    
    
}