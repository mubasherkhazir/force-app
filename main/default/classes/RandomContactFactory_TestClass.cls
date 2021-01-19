@isTest
public class RandomContactFactory_TestClass {

    @isTest
    public static void createTest(){
        
        List<Contact> conList=RandomContactFactory.generateRandomContacts(4,'Mubashir');
        insert conList;
        
        System.assert(conList != NULL);
        
    }
}