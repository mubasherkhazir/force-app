@isTest
public class GetAccountMoreThan_TestClass {
    
    @isTest
    public static void getAccount(){
        
       Pricebook2 pbook2=new Pricebook2();
        pbook2.Id=Test.getStandardPricebookId();
        pbook2.IsActive=true;
        update pbook2;
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Name='new pbook';
        pbook.IsActive=true;
        insert pbook;
        
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
        
        Product2 prod=new Product2();
        prod.Name='yaar';
        insert prod;
       
        
        
        PricebookEntry pb=new PricebookEntry();
        pb.Pricebook2Id=pbook.Id;
        pb.Product2Id=prod.Id;
        pb.IsActive=true;
        pb.UnitPrice=5;
        insert pb;
        
        
        List<OpportunityLineItem> oliList=new List<OpportunityLineItem>();
        for(Integer i=0;i<3;i++){
            OpportunityLineItem oli=new OpportunityLineItem();
            oli.OpportunityId=opp.Id;
            oli.TotalPrice=35;
            oli.PricebookEntryId=pb.Id;
            oli.Quantity=3;
            oliList.add(oli);
            
        }
        if(!oliList.isEmpty())
            insert oliList;
        
        GetAccountMoreThan.getAccount();        
    }
    @isTest
    public static void negativegetAccount(){
       GetAccountMoreThan.getAccount();        

    }
}