@isTest
public class OfferTriggerHelper_TestClass {

    @isTest
    public static void offerTest(){
        Demand__c demand=new Demand__c();
        demand.Name='new demand';
        insert demand;
        
        Offer__c offer=new Offer__c();
        offer.Demand__c=demand.Id;
        offer.Latest_Offer__c=true;
        offer.Name='Mazza aaya';
        insert offer;
    }
}