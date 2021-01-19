public class AccountController {
    
    public static list<Account> accList{get; set;}
    public static String searchString{get; set;}
    
    public static list<Account> getAccountList(){
        accList=[select id,Name,AccountNumber,Phone from Account Order by Name Asc limit 20];
        return accList;
        
    }
    
    
}