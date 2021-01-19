public class treenodes
{
    /* Wrapper class to contain the nodes and their children */
    public class cNodes
    {
        public List<Account> accounts {get; set;}
        Public Account parentAccount {get;set;}
        public cNodes(Account  gp, List<Account> p)
        {      
            accounts = p;      
            parentAccount = gp;  
        } 
    }
    /* end of Wrapper class */
    Public List<cNodes> hierarchy;
    
    Public List<cNodes> getmainnodes()
    {
        hierarchy = new List<cNodes>();
        Id id = apexpages.currentpage().getparameters().get('id');
        if(id !=NULL){
            Account account = [Select Id,Name,ParentId from Account where id =:id ];
            Account acc2=[select id,Name from Account where id =:account.ParentId];
            List<Account> tempchildren = [Select Id,Name from Account where ParentId  =:account.ParentId ];
            hierarchy.add(new cNodes(acc2,tempchildren));
        }
                    return hierarchy;

        
    }
}