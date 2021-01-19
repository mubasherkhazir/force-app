@isTest
public class AccountTriggerHelper_TestClass {
    
    @isTest
    public static void testCreateAccount(){
        
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Active';
        a.Create_Case__c=true;
        a.NumberOfEmployees=105;
        a.Working_in__c='ASIA';
        insert a;
        
    }
    @isTest
    public static void testUpdateAccount(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Active';
        a.NumberOfEmployees=6;
        a.Create_Case__c=false;
        
        a.Working_in__c='ASIA';
        insert a;
        
        Account b=[select id,Name from account limit 1];
        b.NumberOfEmployees=9;
        a.Create_Case__c=true;
        
        update b;
    }
    @isTest
    public static void testUpdateAccount2(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Active';
        a.Create_Case__c=false;
        a.NumberOfEmployees=6;
        a.Working_in__c='ASIA';
        insert a;
        
        Account b=[select id,Name from account limit 1];
        b.Create_Case__c=true;
        b.NumberOfEmployees=4;
        update b;
    }
    @isTest
    public static void testUpdateAccount3(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Not Active';
        a.NumberOfEmployees=6;
        a.Working_in__c='ASIA';
        insert a;
        
        Account b=[select id,Name from account limit 1];
        b.NumberOfEmployees=NULL;
        b.Status__c='Active';
        
        update b;
    }
    @isTest
    public static void testUpdateAccount4(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        a.Status__c='Active';
        a.NumberOfEmployees=NULL;
        a.Working_in__c='ASIA';
        insert a;
        
        Account b=[select id,Name from account limit 1];
        b.NumberOfEmployees=3;
        update b;
    }
    
    @isTest
    public static void changeOpportunityParent(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
        Account a=new Account();
        a.Name='Mubashir Khazir';
        a.AccountNumber='213321';
        insert a;

        Account ab=new Account();
        ab.Name='Mubashir Khazir 2';
        ab.ParentId=a.id;
        insert ab;
        
         Opportunity opp = new Opportunity();
        opp.CloseDate=date.today().addMonths(2);
        opp.AccountId=ab.id;
        opp.Name='test opp';
        opp.StageName='Closed Won';
        insert opp;
        
        Map<ID,Account> accMap=new Map<ID,Account>([select id,name from Account where Name='Mubashir Khazir 2' limit 1]);
        AccountTriggerHelper.changeOpportunityParent(accMap);
    }
    @isTest
    public static void changeOpportunityParent2(){
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        
       

        Account ab=new Account();
        ab.Name='Mubashir Khazir 2';
        insert ab;
        
         Opportunity opp = new Opportunity();
        opp.CloseDate=date.today().addMonths(2);
        opp.AccountId=ab.id;
        opp.Name='test opp';
        opp.StageName='Closed Won';
        insert opp;
        
        Map<ID,Account> accMap=new Map<ID,Account>([select id,name from Account where Name='Mubashir Khazir 2' limit 1]);
        AccountTriggerHelper.changeOpportunityParent(accMap);
    }
    
}