public class CampingListControllerApex{

    
    @AuraEnabled
    public static Camping_Item__c getItems(){
        
        return [SELECT Id, Name, Quantity__c, Price__c, Packed__c FROM Camping_Item__c limit 1];
    }
    
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c camping) {
        // Perform isUpdateable() checking first, then
        insert camping;
        return camping;
    }
}