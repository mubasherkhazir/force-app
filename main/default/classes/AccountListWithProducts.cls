/*
*WAP to get the List of Account with number of Products in Ascending order.Use of map is necessary
*/
public class AccountListWithProducts {
    
    public static void listAccount()
    {
        Map<ID,Account> accountMap=new Map<ID,Account>([select id,Name from Account limit 4500]);
        System.debug('Account Map >>> '+accountMap);
        
        
        Set<ID> acctID=accountMap.keySet();   
        System.debug('acctID >>>>>> '+acctID);
        
        
        Map<ID,Opportunity> opporMap=new Map<ID,Opportunity>([select id,AccountId,(select id,Name from OpportunityLineItems) from Opportunity where AccountID in:acctID limit 4500]);
        System.debug('opporMap>>>>>>>>>>>>>> '+opporMap);
        
        
        //This will be used to store every account with their no of products, duplicacy is not allowed so we are going to use list of accounts to show it.
        Map<Integer,list<Account>> accountProductMap=new Map<Integer,list<Account>>();
        try{
            for(Account account:accountMap.values())
            {
                System.debug('Account inside Loop '+account);
				Integer size=0;
                for(Opportunity oppo:opporMap.values())
                {
                    if(account.Id==oppo.AccountId)
                    {
                      System.debug(' Opportunity inside looop'+oppo);

                        if(!oppo.OpportunityLineItems.isEmpty())
                            size +=oppo.OpportunityLineItems.size();
                    }
                }
                    if(!accountProductMap.containsKey(size))
                    {
                        accountProductMap.put(size,new List<Account>{account});
                    }
                    else
                    {
                        accountProductMap.get(size).add(account);
                    }
                }
            
            List<Integer> sorted=new List<Integer>();
            sorted.addAll(accountproductMap.keySet());
            sorted.sort();
            
            for(Integer key:sorted)
            {
                System.debug('Product Count :: '+key+ ', Accounts :: '+accountProductMap.get(key));
                
            }
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
        
        
    }
}