public class ContactsController {
    Account account;
    Contact contact;
    
    public Contact getContact() {
        if(contact == null) contact = new Contact();
        return contact;
        
    } 
    public String selectedContact{set; get;}
       
        public String getSelectedContacts()
    {
        return selectedContact;
    }
    
    public void setSelectedContact(String sel)
    {
        selectedContact=sel;
    }
    
    public List<SelectOption> contactList;
    
    public List<SelectOption> getContacts () {
        if (contactList == null) {
            List<Contact> contactee = [select id, name,AccountId from Contact ];
            contactList = new List<SelectOption>();
            for (Contact c : contactee) {
                contactList.add(new SelectOption(c.id, c.name ));
            }
        }
        return contactList;
    }
    
    public List<Contact> contactsList {get;set;}
    public Account accName {get;set;}

    
    public PageReference test()
    {
        // blank out any earlier contact details
        contactsList=new List<Contact>();
        if (null!=selectedContact)
        {
            
            System.debug('Selected con'+selectedContact);
            contactsList=[select id,name,AccountID from Contact where id =:selectedContact];
            accName=[select id,Name from Account where id=:contactsList[0].AccountID];
            
        }
        return null;
    }
    
}