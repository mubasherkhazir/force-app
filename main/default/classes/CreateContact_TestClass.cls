@isTest
public class CreateContact_TestClass {
@isTest
    public static void createContact(){
        Pricebook2 pbook2=new Pricebook2();
        pbook2.Id=Test.getStandardPricebookId();
        pbook2.IsActive=true;
        update pbook2;
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Name='new pbook';
        pbook.IsActive=true;
        insert pbook;
        
		Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        Contact c=CreateContact.createContact('hello', a.Id);
    }
}