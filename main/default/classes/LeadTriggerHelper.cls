//Create a trigger on Lead to run when the lead stage is """"Completed"""" to create
// an Opportunity with Opportunity line Item and Product from Lead related list.[create custom lookup]
//If Lead is having 3 Products in its related list then Opportunity 
//must have 3 Opportunity line Items with those products and 1 quantity."

public class LeadTriggerHelper {
    
    public static void createOpportunity(Map<id,Lead> leadMap){
        Set<ID> leadId=leadMap.keySet();
        System.debug('LeadID'+LeadID);
        
        /* Map<ID,Product2> productMap=new Map<ID,product2>([select id,Name from Product2 where Lead__c in
(select id from Lead where isConverted=true
and id in:leadID) limit 445]); */
        
        Map<ID,Product2> productMap=new Map<ID,product2>([select id,Name from Product2 where Lead__c in
                                                          (select id from Lead where status='Closed - Converted'
                                                           and id in:leadID) limit 445]);
        
        Set<ID> prodID=productMap.keySet();
        System.debug('product Map >>> v'+productMap);
        
        try{
            
            Pricebook2 standardpb=[select id from pricebook2 where isStandard=true limit 1];
            system.debug('standardpb>>>>>>>>>>>>>>>'+standardpb);
            
            pricebook2 pricebook=new Pricebook2();
            pricebook.Name='New pricebook';
            pricebook.IsActive=true;
            insert pricebook;
            System.debug('Pricebook '+pricebook);
            
            
            
            Opportunity opportunity=new Opportunity();
            opportunity.Name='Lead Opportunity ';
            opportunity.CloseDate=System.today() +30;
            opportunity.StageName='New';
            insert opportunity;
            
            System.debug('Opportunity '+opportunity);
            
            List<PricebookEntry> pbentryList=new List<PricebookEntry>();
            for(Product2 product:productMap.values()){
                PricebookEntry pbentry=new PricebookEntry();
                pbentry.Pricebook2Id=pricebook.Id;
                pbentry.Product2Id=product.Id;
                pbentry.IsActive=true;
                pbentry.UnitPrice=1;
                pbentryList.add(pbentry);
            }
            
            if(!pbentryList.isEmpty()){
                insert pbentryList;
            }
            System.debug('Pbentry list :: '+pbentryList);
            
            List<OpportunityLineItem> oliList=new List<OpportunityLineItem>();
            for(PricebookEntry pbentry:pbentryList){
                OpportunityLineItem oli=new OpportunityLineItem();
                oli.OpportunityId=opportunity.Id;
                oli.Product2Id= pbentry.Product2Id;
                oli.PricebookEntryId=pbentry.Id;
                oli.Quantity=1;
                oli.UnitPrice=3;
                oliList.add(oli);
                
            }
            if(!oliList.isEmpty())
                insert oliList;
            System.debug('oli List :: '+oliList);
            
        }
        Catch(Exception e){
            System.debug('Exception caught in Lead '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
        
    }
    
    
}