@isTest
public class CreateOpportunity_TestClass {

    @isTest
    public static void testCreateOpp(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        CreateOpportunity.createOpportunity('New Opp',a.Id);
        
    }
}