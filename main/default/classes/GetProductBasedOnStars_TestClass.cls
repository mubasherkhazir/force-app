@isTest
public class GetProductBasedOnStars_TestClass {
 
    @isTest
    public static void getProductTest(){
        
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
        prod.Rate__c='2 Star';
        prod.Rating__c='2 Star';
        insert prod;
        
        
        PricebookEntry pb=new PricebookEntry();
        pb.Pricebook2Id=pbook.Id;
        pb.Product2Id=prod.Id;
        pb.IsActive=true;
        pb.UseStandardPrice=false;
        pb.UnitPrice=4;
        insert pb;
        
        
        List<OpportunityLineItem> oliList=new List<OpportunityLineItem>();
        for(Integer i=0;i<4;i++){
            OpportunityLineItem oli=new OpportunityLineItem();
            oli.OpportunityId=opp.Id;
            oli.TotalPrice=35;
            oli.Rate__c='5 Star';
            oli.PricebookEntryId=pb.Id;
            oli.Quantity=3;
            oliList.add(oli);
            
        }
        if(!oliList.isEmpty())
            insert oliList;

GetProductBasedOnStars.getProducts();        
    }
}