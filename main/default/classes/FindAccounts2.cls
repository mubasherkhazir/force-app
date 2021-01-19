//Write a script to find accounts in org having number of contacts greater
//than 4 with last name containing alphabet 'O' . Update the account field
//of all these contacts found with the most recent created Account among the list.

public class FindAccounts2 {
    
    public static void findAccouts(){
        List<Contact> contactlist=new List<Contact>();
        Map<Id,Account> accountMap=new Map<Id,Account>([Select id,Name,(Select id,LastName from Contacts) from Account limit 1120]);
        
        for(Account account:accountMap.values())
        {
            if(account.contacts.size()>4)
            {
                for(Contact con:account.Contacts)
                {
                    if(con.LastName.Contains('o'))
                    {
                      contactList.add(con);  
                    }
                }
            }
        }
        Account newAccount=[select id from Account order by createdDate DESC limit 1];
       
        for(Contact contact:contactList){
            contact.AccountId=newAccount.ID;
        }
        
        if(!contactList.isEmpty()){
            update contactList;
        }
        
        
    }	
    
}