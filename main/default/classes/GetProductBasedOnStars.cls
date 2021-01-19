/*
 * 
 * """Create a Multi picklist field """"Rate"""" [Values as 1 star, 2 stars, 3 stars, 4 stars, 5 stars]
 *  on Product2 and same Multi picklist field """"Rate"""" on Opportunitylineitem with the same value.
 * Write a script to get all the Products which got less than 3 ratings in opportunity line items but 
 * the Product rate for those was 5 star."""
 */ 

public class GetProductBasedOnStars {

    public static void getProducts(){
        
       Map<ID,Product2> productMap=new Map<ID,Product2>([select id,Name,Rate__C from Product2 where Rate__c='5 Star' and Id in (select Product2ID from OpportunityLineItem where (Rate__c != '5 Star' or Rate__c !='4 Star') ) limit 500]);
       System.debug('Product Map '+productMap);
        
        
    }
    
}