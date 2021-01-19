@isTest
public class UpdateContactAcquisition_TestClass {

    @isTest
    public static void updateContact(){
        
        Contact c=new Contact();
        c.LastName='con';
        insert c;
        
        Property__c prop=new Property__c();
        prop.Last_Sale_Date__c=System.today();
        prop.Last_Sale_Price__c=1000;
        prop.Contact__c=c.id;
        prop.Name='property';
        insert prop;
        
    }
}