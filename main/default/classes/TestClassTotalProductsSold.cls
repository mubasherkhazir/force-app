@isTest
public class TestClassTotalProductsSold {
    
    @isTest 
    public static void testClass(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        Opportunity opp=new Opportunity();
        opp.Name='Opportunity';
        opp.AccountId=a.Id;
        opp.CloseDate=System.today();
        opp.StageName='Closed Won';
        insert opp;
        TotalProductsSold.productSold();
    }
}