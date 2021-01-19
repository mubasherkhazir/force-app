@IsTest
public class AccountManagerTest {

        @isTest 
    public static void testGetAccountbyId() 
    {
        Id recordId = createTestRecord();
		RestRequest request = new RestRequest();
        request.requestUri ='https://mubashir-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
    }
    
    static Id createTestRecord() {
        // Create test record
        Account account = new Account(
            Name='Test record');
        insert account;
        return account.Id;
    }          

    
}