@isTest
public class ContactController_TestClass {

    @isTest
    public static void testContact(){
        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<2;i++){
            Contact c=new Contact();
            c.LastName='mubi';
            conList.add(c);
        }
        insert conList;
        ContactController.getContacts();
    }
}