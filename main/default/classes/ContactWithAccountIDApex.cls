public class ContactWithAccountIDApex {
    
    @AuraEnabled
    public static List<Account> getAccounts(){
        
        return [select id,Name from Account limit 10];
    }

}