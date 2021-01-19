@isTest(SeeAllData=true)
public class TestClassTvRemote {
    
    @isTest
    public static void checkConstructor(){
        new TVRemoteControl(20);
    }
    
    @isTest
    private static void increaseVolume(){
        TVRemoteControl tv= new TVRemoteControl(10);
        Integer v=tv.increaseVolume(20);
        Integer max=tv.increaseVolume(50);
    }
    
    @isTest
    public static void decreaseVolume(){
        TVRemoteControl tv= new TVRemoteControl(10);
        Integer v=tv.decreaseVolume(20);
    }
    
    @isTest
    public static void testMenu(){
        String s=TVRemoteControl.getMenuOptions();
    }
    
    @isTest
    public static void getAccounts(){
        Account a=[select name from account where name like 'MUBASHIR' limit 1];
        System.assert(a != null);
        
        System.debug(a);
        Account b=a.clone();
        b.Name='test Mubashir';
        insert b;
        Account c=[select name from account where name like 'test Mubashir' limit 1];
        System.assert(b != null);
        System.debug(c);
    }
    @isTest static void myTestMethod2() {
        // Can access all data in the organization.
		
      Account a=[select name from account where name like 'MUBASHIR' limit 1];
        System.assert(a != null);
        
        System.debug(a);   
    }
    
    @isTest
    public static void testException(){
        TVRemoteControl tv= new TVRemoteControl(null);
        
    }
}