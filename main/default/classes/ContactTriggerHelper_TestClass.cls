@isTest
public class ContactTriggerHelper_TestClass {
    
    @isTest
    public static void updateAccountTest(){
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
        
        Contact c=new contact();
        c.LastName='Contact';
        c.AccountId=a.Id;
        insert c;
        
        Map<id,Contact> conMap=new Map<id,Contact>([select id,LastName,AccountID from contact limit 1]);
        ContactTriggerHelper.deleteLastName(conMap);
        
    }
    @isTest
    public static void changeStatus(){
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<4;i++){
            Contact c=new contact();
            c.LastName='Contact';
            c.Status2__c='Close';
            c.AccountId=a.Id;
            conList.add(c);
        }
        insert conList;
    }
    
}