public class OfferTriggerHelper {
    //Offer__c Demand__c Latest_Offer__c	
    
    public static void offer(){
        
       
        
        //RESPECTIVE DEMANDS AVAILABLE
        Map<ID,Demand__c> demandMap=new Map<ID,Demand__c>([select id,(select ID,Latest_Offer__c,Demand__c from Offers__r order by createdDate DESC) from Demand__c  limit 500 ]);
        System.debug('demand map '+demandMap);
        set<ID> demandId=demandMap.keySet(); 
        
        //  List <Offer__c> offersMap=[select ID,Latest_Offer__c,Demand__c from Offer__c where Demand__C in:demandID  order by createdDate DESC];
        //System.debug('Offfffffffers   '+offersMap);
        
        
        // Offer__c o=offersMap[0];
        
        List<Offer__c> off   =new List<Offer__c>();
        
        for(Demand__c demand:demandMap.values()){
            List<Offer__c> offerList=demand.offers__r;
            for(Offer__c offer:offerList)
            {
                if(offer==offerList[0]){
                    System.debug('Inside true');
                    offer.Latest_Offer__c=true;
                    off.add(offer);
                } 
                else{
                    System.debug('inside false');
                    offer.Latest_Offer__c=false;
                    off.add(offer);
                }
            }
          
        }
        System.debug('Offers Map now '+off);
        update off;
    
    }
    
}