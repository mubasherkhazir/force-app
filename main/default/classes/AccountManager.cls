@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager{
    @HttpGet
    global static Account getAccount() {
        
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');
        Account result =  [SELECT id,Name,(select id,Name from contacts) from Account WHERE Id =:accountId];
        return result;
        
        }


}