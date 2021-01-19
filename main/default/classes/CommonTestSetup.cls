@isTest 
private class CommonTestSetup {
    @testSetup 
    static void setup() {
        // Create common test accounts 
        Pricebook2 pbook2=new Pricebook2();
        pbook2.Id=Test.getStandardPricebookId();
        pbook2.IsActive=true;
        update pbook2;
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Name='new pbook';
        pbook.IsActive=true;
        insert pbook;
        
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
    }
    @isTest 
    static void testMethod1() {
        // Get the first test account by using a SOQL query 
        Account acct = [SELECT Id FROM Account WHERE Name='TestAcct0' LIMIT 1 FOR UPDATE];
        // Modify first account 
        acct.Phone = '555-1212'; // This update is local to this test method only. 
        update acct;
        // Delete second account 
        Account acct2 = [SELECT Id FROM Account WHERE Name='TestAcct1' LIMIT 1];
        // This deletion is local to this test method only. 
        delete acct2;
        // Perform some testing 
    }
    @isTest static void testMethod2() { 
        // The changes made by testMethod1() are rolled back and
        // are not visible to this test method. 
        // Get the first account by using a SOQL query 
        Account acct = [SELECT Phone FROM Account WHERE Name='TestAcct0' LIMIT 1 FOR UPDATE];
        // Verify that test account created by test setup method is unaltered. 
        System.assertEquals(null, acct.Phone);
        // Get the second account by using a SOQL query 
        Account acct2 = [SELECT Id FROM Account WHERE Name='TestAcct1' LIMIT 1];
        // Verify test account created by test setup method is unaltered. 
        System.assertNotEquals(null, acct2);
        // Perform some testing
    }
}