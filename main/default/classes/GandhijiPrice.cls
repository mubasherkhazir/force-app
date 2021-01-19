/*
* Create a new Product ""Gandhiji Chasma"". Add Price as 100$ in standard price book 
* and any other price books as well. Create few oppportunites with Opportunity line item
*  ""Gandhiji Chasma"". Write a script to get the total Price of all the Opportunity
*  sold having Product ""Gandhiji Chasma"""
*/ 

public class GandhijiPrice {
    
    public static void getTotalPrice(){
        
        Map<ID,OpportunityLineItem> oppLineItem=new Map<ID,OpportunityLineItem>([select id,TotalPrice 
                     from OpportunityLineItem where Product2.Name='Gandhiji Chasma' AND Opportunity.isWon=true limit 500]);
        System.debug('OpptunityLineItem '+oppLineItem);
        Decimal netPrice=0;
        
        for(OpportunityLineItem oli:oppLineItem.values()){
            
            netPrice +=oli.TotalPrice;
            
        }
        
        System.debug('Total Price of all the opportunities sold '+netPrice);
        
    }
    
}