public class AddPrimaryContact implements Queueable{
    
    private Contact cts;
    private String find;
    public AddPrimaryContact(Contact ct,String state){
        cts=ct;
        find=state;
        
    }
    
    
    public void execute(System.QueueableContext qc){
        List<Account> accList=[select id,Name from Account where BillingState =:find limit 200];
        List<Contact> conList=new List<Contact>();
        for(Account ac:accList){
            Contact c=cts.clone(false,false);
            c.AccountId=ac.id;
            conList.add(c);
        }
        
        if(!conList.isEmpty())
            insert conList;
        
    }

}