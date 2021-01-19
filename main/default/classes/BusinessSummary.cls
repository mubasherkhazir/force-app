public class BusinessSummary {
    /* Wrapper class to contain the Account and their related items */
    public class AccountWrapper
    {
        Public Account parentAccount {get;set;}
        public Integer conSize{get; set;}
        public Integer opSize{get; set;}
        public Integer oliSize{get; set;}
        public AccountWrapper(Account  a,Integer c,Integer op,Integer oli)
        {      
            parentAccount = a;
            conSize=c;
            opSize=op;
            oliSize=oli;
        } 
    }
    public List<AccountWrapper> accDetails;
    public List<AccountWrapper> getData(){
        
        accDetails=new List<AccountWrapper>();
        
        Map<id,Account> accMap=new Map<id,Account>([select id,Name,(select id,Name
                                                                    from contacts),(select id,Name from 
                                                                                    Opportunities) from Account limit 10 ]);
        
        Set<id> acId=accMap.keySet();
        
        Map<ID,Opportunity> opportunityMap2=new Map<ID,Opportunity>([select id,Name,AccountID,(select id from OpportunityLineItems) from
                                                                     Opportunity where AccountID IN:acID limit 500]);
        try{
            for(Account a:accMap.values()){
                Integer totalLineItems=0;
                Integer conSiz=0;
                if(a.contacts.size()!=NULL)
                    conSiz =a.contacts.size();
                
                Integer OpSiz=0;
                if(a.Opportunities.size() !=NULL)
                    OpSiz=a.Opportunities.size();
                
                for(Opportunity opp:opportunityMap2.values())
                {
                    if(opp.AccountId==a.Id){
                        if(opp.OpportunityLineItems.size()!=NULL)
                            totalLineItems  +=opp.OpportunityLineItems.size(); 
                    }
                }
                System.debug('Accont '+a+' consize '+conSiz+' opsize '+OpSiz+' olisize '+totalLineItems);
                accDetails.add(new AccountWrapper(a,conSiz,OpSiz,totalLineItems));
            }
        }Catch(Exception e){
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            System.debug(e.getCause());
        }
        
        return accDetails;
        
    }
    
}