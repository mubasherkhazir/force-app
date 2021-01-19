public class CreateContact {
    
     public static Contact createContact(String Last,ID accID){
        Contact contact=new Contact();
        contact.LastName=Last;
        contact.AccountId=accID;
        return contact;
    }


}