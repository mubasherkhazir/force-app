@isTest
public class CopyQuickLinks_TestClass {
    
    @isTest
    public static void copyQuickTest(){
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Working_in__c='ASIA';
        insert a;
        
        Contact c=new Contact();
        c.LastName='Test contact';
        c.AccountId=a.Id;
        insert c;
        
        Help__c helps=new Help__c();
        helps.Name='NEW HELP';
        helps.Account__c=a.id;
        helps.URL__c='www.google.com';
        insert helps; 
        
        QuickLinks__c quick=new QuickLinks__c();
        quick.Account__c=a.id;
        quick.URL__c='www.google.com';
        quick.Contact__c=c.Id;
        insert quick;
        
        CopyQuickLinks.copyLinks();
    }
}