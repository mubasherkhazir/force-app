@isTest
public class FindAccounts_TestClass {

    @isTest
    public static void testFind(){
     
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
             Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Active';
        a.Create_Case__c=true;
        a.NumberOfEmployees=105;
        a.Working_in__c='ASIA';
        insert a;
        
        FindAccounts.findAccount();
        FindAccounts.findAccount1();
    }
}