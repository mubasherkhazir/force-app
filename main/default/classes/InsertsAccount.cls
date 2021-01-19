public with Sharing class InsertsAccount {
    @AuraEnabled
    public static Account saveAccount(Account acc){
        insert acc;
        return acc;
    }

}