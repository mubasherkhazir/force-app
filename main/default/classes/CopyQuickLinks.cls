/*
*  Write a Script to copy all Quick link URLs on Help only for Accounts
* which are having exactly one Help and one Quick links in its related list .""
* 
*/ 

public class CopyQuickLinks {
    public static void copyLinks(){
        List<QuickLinks__C> quickList=new  List<QuickLinks__C>();
        List<Help__c> helpList=new List<Help__c>();
        
        Map<ID,Account> accountMap=new Map<ID,Account>([select ID,Name, (select id,URL__c,Account__c
                             from QuickLinks__r),(select id,URL__c,Account__c from Helps__r) from Account limit 500]);
        
        for(Account account:accountMap.values())
        { 
            
            if(account.QuickLinks__r.size()==1 && account.helps__r.size()==1){
                System.debug('Account Name '+account.Name);
                System.debug('Just 1 quick links and 1 help related');
                //QuickLinks__C
                QuickLinks__C quick=accountMap.get(account.id).QuickLinks__r;
                quicklist.add(quick);
                Help__c  help=accountMap.get(account.Id).Helps__r;
                helpList.add(help);
                
                //helpList.Url__c=QuickList.Url__c;
                //System.debug('QuickList url'+QuickList.Url__c);
                //System.debug('helpList url '+helpList.Url__c);
            }    
            
        }
        //update accountMap.values();
        for(QuickLinks__c ql:QuickList){
            for(Help__c hp:helpList){
                if(ql.Account__c == hp.Account__c){
                    hp.Url__c=ql.Url__c;
                }
            }
        }
        if(!helpList.isEmpty())
        update helpList;
        
        
        
        
        
    }
    
}