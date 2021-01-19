@isTest
public class CreateNewAccountApexController_TestClass{
    
    @isTest
    public static void createTest(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        List<Account> accList =new List<Account>();
        for(Integer i=0;i<3;i++){
            Account a=new Account();
            a.Name='Mubashir Khazir';
            a.AccountNumber='213321';
            a.Working_in__c='ASIA';
            accList.add(a);
        }
        CreateNewAccountApexController.createAccountApex(accList);
    }
}