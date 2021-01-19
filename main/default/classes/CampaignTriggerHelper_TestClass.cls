@isTest
public class CampaignTriggerHelper_TestClass {
    
    @isTest
    public static void testCampaignOpps(){
        Campaign camp=new Campaign();
        camp.Name='New Campaign';
        camp.Status='Planned';
        insert camp;
        
        Opportunity opp = new Opportunity();
        opp.CloseDate=date.today().addMonths(2);
        opp.Name='test opp';
        opp.CampaignId=camp.Id;
        opp.StageName='Closed Won';
        insert opp;
        
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Name='new pbook';
        pbook.IsActive=true;
        insert pbook;
        
        Pricebook2 pbook2=new Pricebook2();
        pbook2.IsActive=true;
        pbook2.Id=Test.getStandardPricebookId();
        update pbook2; 
        
        Product2 prod=new Product2();
        prod.Name='yaar';
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
            oli.PricebookEntryId=pb.Id;
            oli.Quantity=3;
            oliList.add(oli);
            
        }
        if(!oliList.isEmpty())
            insert oliList;
        
        Campaign c=[select Name from Campaign limit 1];
        c.Status='Completed';
        update c;
        
    }
     @isTest
    public static void negativeResult(){
        Campaign camp=new Campaign();
        camp.Name='New Campaign';
        camp.Status='Planned';
        insert camp;
        
        Opportunity opp = new Opportunity();
        opp.CloseDate=date.today().addMonths(2);
        opp.Name='test opp';
        opp.CampaignId=camp.Id;
        opp.StageName='Closed Won';
        insert opp;
        
        Contact con=new Contact();
        con.LastName='cont';
        con.Email='mubashir.khazir@gmail.com';
        insert con;
        
        Lead ld=new Lead();
        ld.LastName='bew';
        ld.Company='Cloud Analogy';
        insert ld;
        
        CampaignMember cm=new CampaignMember();
        cm.CampaignId=camp.Id;
        cm.ContactId=con.id;
        cm.LeadId=ld.Id;
        insert cm;
        
        Campaign c=[select Name from Campaign limit 1];
        c.Status='Completed';
        update c;
    }
}