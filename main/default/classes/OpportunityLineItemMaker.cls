@isTest
public class OpportunityLineItemMaker {

    @isTest
    public static List<OpportunityLineItem> createOli(){
        Pricebook2 pbook2=new Pricebook2();
        pbook2.Id=Test.getStandardPricebookId();
        pbook2.IsActive=true;
        update pbook2;
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Name='new pbook';
        pbook.IsActive=true;
        insert pbook;
        
        Product2 prod=new Product2();
        prod.Name='yaar';
        prod.Rating__c='2 Star';
        prod.Rate__c='2 Star';
        insert prod;
        
        
        PricebookEntry pb=new PricebookEntry();
        pb.Pricebook2Id=pbook.Id;
        pb.Product2Id=prod.Id;
        pb.IsActive=true;
        pb.UseStandardPrice=false;
        pb.UnitPrice=4;
        insert pb;
        
        List<Opportunity> opp=OpportunityMaker.createOpportunity();
        System.debug('Opportunity list ???'+opp);
        List<OpportunityLineItem> oliList=new List<OpportunityLineItem>();
        for(Integer i=0;i<10;i++){
            OpportunityLineItem oli=new OpportunityLineItem();
            oli.OpportunityId=opp[0].Id;
            oli.TotalPrice=35;
            oli.PricebookEntryId=pb.Id;
            oli.Rate__c='5 Star';
            oli.Quantity=3;
            oliList.add(oli);
            
        }
        if(!oliList.isEmpty())
            insert oliList;
        
        return oliList;
    }
}