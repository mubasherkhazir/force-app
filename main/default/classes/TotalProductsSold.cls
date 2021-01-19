/*
* "In Account Object create a Multi picklist """"Working in (ASIA, EMA, NA, SA)"""" Multi picklist.
Write a script to get the total Quantity of Products sold in only Accounts working in ASIA."""
*/
public class TotalProductsSold {
    public static void productSold(){
        //Map<ID,Account> accountMap=new Map<ID,Account>([select id from Account where Working_in__c='ASIA' limit 500]);
        
        Map<ID,Opportunity> opportunityMap=new Map<ID,Opportunity>([select id,Name from Opportunity where
                                     isWon=true AND AccountID in (select id from Account 
                                                where Working_in__c='ASIA') limit 5000]);
        
        System.debug('Opportunity Map in Product sold'+opportunityMap);
        set<ID> oppSet=opportunityMap.keySet();
        
        Map<id,OpportunityLineItem> oliMap=new Map<id,OpportunityLineItem>([select id,Name,Quantity,
                       Product2.Name,Product2ID from OpportunityLineItem where OpportunityID in :Oppset limit 500]);
       
        System.debug('Oli Map >>>>>>> '+oliMap);
        
        Decimal tquantity=0;
        for(OpportunityLineItem oli:oliMap.values()){
				System.debug('Prduct name '+oli.Product2.Name+' Quantity '+oli.Quantity);
            tquantity +=oli.Quantity;
        }
        System.debug('Total quantity sold '+tQuantity);
    }
}