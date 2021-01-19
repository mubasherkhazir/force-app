@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testContact(){
        //Pricebook2 pbook=new Pricebook2();
        //pbook.Id=Test.getStandardPricebookId();
        //pbook.IsActive=true;
        //update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        Account ab=[select id from Account limit 1];
        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<4;i++){
            Contact c=new contact();
            c.LastName='Contact';
            c.Status2__c='Close';
            c.AccountId=ab.Id;
            conList.add(c);
        }
        insert conList; 
        
        List<ID> aList=new List<ID>();
        aList.add(ab.Id);
        Test.startTest();
        AccountProcessor.countContacts(aList);
        Test.stopTest();
    }
}