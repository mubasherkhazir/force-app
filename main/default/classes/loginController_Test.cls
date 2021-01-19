@isTest
public class loginController_Test {
    
    @testSetup
    public static void createTestData(){
        Test.startTest();
        Contact con=new Contact();
        con.LastName='lone';
        con.Email='mubasher.khazir@cloudanalogy.com';
        insert con;
        Test.stopTest();
    }
    
    @isTest
    public static void test(){
        
        
                Test.startTest();

        Test.setCurrentPage(Page.GoogleLogin);
        ApexPages.currentPage().getParameters().put('code','4/1gEVbsk4Fac5tiTPvlo0sVcdfFY1-hnYPMr7TUZpTfqntC9uvRwiI2nZ4aePDsIy3lwZsjCNAaJmoW_9xY3-4z4&client_id=466609379780-c4kj7jv89tq1ditbjnocn2vtpmbqjfrt.apps.googleusercontent.com&client_secret=qUjrdZbAfYH5FkMFOFwGE1AM&redirect_uri=https://mubashir-dev-ed--c.visualforce.com/apex/GoogleLogin&grant_type=authorization_code');
        loginController login=new loginController();
        Test.setMock(HttpCalloutMock.class, new HttpMockClass1());
        
        login.googleSignIn();
        login.getAccessToken();
                Test.stopTest();

    }
    
}