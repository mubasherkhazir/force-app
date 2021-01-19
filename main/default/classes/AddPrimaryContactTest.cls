@isTest
public class AddPrimaryContactTest {

    @isTest
    public static void testCon(){
        
        List<Account> accList=new List<Account>();
        List<Account> accList2=new List<Account>();
        for(Integer i=0;i<50;i++)
        {
            Account a=new Account();
            a.Name='Test acc';
            a.BillingState='NY';
            accList.add(a);
        }
        insert accList;
        for(Integer i=0;i<50;i++)
        {
            Account a=new Account();
            a.Name='Test acc';
            a.BillingState='CA';
            accList2.add(a);
        }
        insert accList2;
        
        Contact c=new Contact();
        c.LastName='hello contact';
        insert c;
        
        List<Account> accounts = [select id, name from account];
        AddPrimaryContact adc=new AddPrimaryContact(c,'NY');
        Test.startTest();        
        System.enqueueJob(adc);
        Test.stopTest();
        
    }
}