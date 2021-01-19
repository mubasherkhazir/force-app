@isTest
public class TestClassAccountListWithProducts {
    
    @isTest
    public static void testAccount(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        Opportunity opp = new Opportunity();
        opp.CloseDate=date.today().addMonths(2);
        opp.AccountId=a.id;
        opp.Name='test opp';
        opp.StageName='Closed Won';
        insert opp;
        
       
        AccountListWithProducts.listAccount();
    }
    
}