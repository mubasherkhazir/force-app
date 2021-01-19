@isTest
public class ContactWithAccountIDApex_TestClass {

    @isTest
    public static void testContact(){
        
        Account acc=new Account();
        acc.Name='Brand new';
        insert acc;
        ContactWithAccountIDApex.getAccounts();
    }
}