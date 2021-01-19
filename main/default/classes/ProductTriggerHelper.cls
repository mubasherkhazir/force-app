public class ProductTriggerHelper {
    
/*
 * On Product to setup default Pricebook entry in the “Standard Pricebook” as 1$
 * Product2-----> pricebookentry -----> Pricebook2
 */
    public static void priceBookEntry(Map<ID,Product2> product2Map){
        
        System.debug('Product map>>>>>>>>>>>>>'+product2Map);
        Map<ID,Pricebook2> pricebookMap=new Map<ID,Pricebook2>([select id from Pricebook2 where isStandard=True]);
        List<PricebookEntry> pbentryList=new List<PricebookEntry>();
        //Map<ID,PricebookEntry> pbEntryMap=new Map<ID,PRICEBOOKENTRY>();
        
        try{
           for(ID product:product2Map.keySet()){
           for(ID pricebook:pricebookMap.keySet()){
           PricebookEntry pbentry=new PricebookEntry();
           pbentry.Pricebook2Id=pricebookMap.get(pricebook).id;
           pbentry.Product2Id=product2Map.get(product).id;
           pbentry.UnitPrice=1;
           pbentry.UseStandardPrice=false;
           pbentryList.add(pbentry);
           //pbEntryMap.put(pricebook,pbentry);
        }
        }
            //insert pbEntryMap.values();
        insert pbentryList;
        }Catch(Exception e){
            System.debug('Exception '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
    }

}