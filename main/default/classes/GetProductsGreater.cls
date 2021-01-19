/*
"Write a Script to get all the Products Name(in a list) which were sold with
Quantity(Opportunitylineitem) > 100 under their Opportunities(CLOSED WON only).
Note - Consider Only that OpportunityLineItems whose first enterd Quantity value > 100.
For example - OpportunityLineItem - OppL1 (Product - p)-> Quantity = 120
OppL2 (Product - p1)-> Quantity = 80 OpplL3 (Product - p1) -> Quantity = 30
Only OppL1 should be considered for ProducName."
*/
public class GetProductsGreater {
    public static void getProduct(){
        Map<ID,OpportunityLineITem> oliMap=new Map<ID,OpportunityLineITem>([select id,Product2.Name,Opportunity.Name,Quantity from OpportunityLineItem where Quantity>100 and Opportunity.isWon=true limit 500]);
        System.debug('Opportunity line item map'+oliMap);
        for(OpportunityLineItem oli:oliMap.values()){
            System.debug('Product Name ::'+oli.Product2.Name +', Quantity ::'+oli.Quantity+ ', Opportunity Name ::'+oli.Opportunity.Name);
        }
    
    
    
    
    
    }
    
    
    
    
}