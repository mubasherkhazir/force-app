@isTest
public class TestClassFindAccounts2 {
    
    @isTest
    public static void getAcc(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        List<contact> contactList=new List<contact>();
        for(integer i=0;i<=5;i++){
            Contact c=new Contact();
            c.LastName='Test contact';
            c.AccountId=a.Id;
            contactList.add(c);
        }
        insert contactList;
        
        FindAccounts2.findAccouts();
        
    }
    
}