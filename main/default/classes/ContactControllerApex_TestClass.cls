@isTest
public class ContactControllerApex_TestClass {

    @isTest
    public static void testContact(){
        Contact c=new Contact();
        c.LastName='con';
        c.Username__c='Mubashir';
        c.Password__c='123';
        
        insert c;
        ContactControllerApex.getDetails('Mubashir', '123');
        ContactControllerApex.getDetails('Mubashir', '32');
       ContactControllerApex.getDetails('Mushir', '123');


    }
    @isTest
    public static void negativeTest(){
        String name=null;
        ContactControllerApex.getDetails(name,'');
    }
}