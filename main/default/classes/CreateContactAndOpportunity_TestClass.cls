@isTest
public class CreateContactAndOpportunity_TestClass {
    @isTest
    public static void createTestOpp(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        a.Status__c='Active';
        insert a;   
        
        CreateContactAndOpportunity.createConAndOpp();
    }
}