public class GetAccountApexController {
    @AuraEnabled
    public static List<Account> getAccount(){
        System.debug([select id,Name,Industry,(select id,Name from contacts),(select id,Name from Opportunities) from Account limit 1000]);
        return [select id,Name,Industry,(select id,Name from contacts),(select id,Name from Opportunities) from Account limit 1000];
        
        
    }

}