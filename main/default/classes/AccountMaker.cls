@isTest
public class AccountMaker {

    @isTest
    public static List<Account> makeAccounts(){
        
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<10;i++){
            
            Account a=new Account();
            a.Name='New Account '+i;
            a.AccountNumber='12342'+i;
            a.NumberOfEmployees=23+i;
            a.Phone='990601234'+i;
            accList.add(a);
        }
        
        if(!accList.isEmpty())
            insert accList;
        
        return accList;
    }
}