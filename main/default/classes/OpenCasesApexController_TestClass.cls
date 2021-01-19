@isTest
public class OpenCasesApexController_TestClass {
    @isTest
    public static void getTestDb(){
        Case caseObj = new Case(
            Status = 'Working',
            Origin = 'Phone');
             insert caseObj;
        OpenCasesApexController.getCasesDB();
    }
    
}