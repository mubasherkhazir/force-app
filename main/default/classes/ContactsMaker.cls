@isTest
public class ContactsMaker {

    public static List<Contact> createContacts(){
                List<Account> accList=AccountMaker.makeAccounts();

        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<10;i++){
            Contact con=new Contact();
            con.LastName='Con '+i;
            con.AccountId=accList[i].id;
            conList.add(con);
            
        }
        if(!conList.isEmpty())
            insert conList;
        
        return conList;
    }
}