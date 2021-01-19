@isTest
public class CampingListControllerApex_TestClass {

    @isTest
    public static void testController(){
        Camping_Item__c camping =new Camping_Item__c();
        camping.Name='new camping';
        camping.Packed__c=true;
        camping.Price__c=200;
        camping.Quantity__c=34;
        
        CampingListControllerApex.saveItem(camping);
        CampingListControllerApex.getItems();
    }
}