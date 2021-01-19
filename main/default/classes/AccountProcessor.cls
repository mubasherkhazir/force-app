public class AccountProcessor {

    @future
    public static void countContacts(List<ID> accID){
        List<Account> accList =[select id,Name,Number_of_Contacts__c,(select id,Name from contacts) from Account where id in :accID limit 20];
        System.debug('In test method '+accList);
        for(Account a:accList){
            if(a.contacts.size()!=NULL)
                a.Number_of_Contacts__c=a.contacts.size();
            System.debug('Account '+a+' contacts '+a.contacts.size());
        }
        update accList;
        
    
    }
}