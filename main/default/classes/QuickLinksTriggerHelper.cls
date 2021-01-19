//Write a trigger to create Help record when QuickLinks record created and 
//also make sure that their is not more then one record of help in Account
//related list if record exist update help record with the new quick link details.

public class QuickLinksTriggerHelper {
    public static void createHelp(Map<ID,QuickLinks__c> quickLinkMap){
        set<ID> quickID=quickLinkMap.keySet();
        Map<id,Account> accountMap=new Map<id,Account>([select id,(select id from helps__r ) from Account where id in (select Account__c from 
                                       QuickLinks__c where id in:quickID) limit 450]);
        System.debug('Account map '+accountMap);
        
                List<Help__c> helpList=new List<Help__c>();
                List<Help__c> helpList2=new List<Help__c>();

        for(QuickLinks__c quick:quickLinkMap.values()){
            System.debug('QuickLinks '+quick);
            if(quick.Account__c !=NULL){
                System.debug('Account linked '+quick.Account__c);
                Account acc=accountMap.get(quick.Account__c);
                if(acc.helps__r.size()==0){
                    System.debug('No help  in it so inserting  ');
                    Help__c help=new Help__c();
                    help.Account__c=acc.Id;
                    help.Company_Name__c='Cloud Analogy';
                    help.Name='new help';
                    helpList.add(help);
                }
                else
                {
                    System.debug('has help so updating');
                    Help__c help=acc.helps__r;
                    //List<Help__c> helpListnew=acc.helps__r; // in case of multiple records. but here the requirement is just 1
					//for(Help__c help:helpListnew)
                    {
                        help.Account__c=quick.Account__c;
                    help.Company_Name__c=quick.Company_Name__c;
                    if(quick.Contact__c !=NULL)
                    help.Contact__c=quick.Contact__c;
                    help.Name=quick.Name;
                     helpList2.add(help);
                    }
                    
                }
            }
        }
        
		System.debug('help List '+helpList);        
        if(!helpList.isEmpty())
            insert helpList;
		if(!helpList2.isEmpty())
            update helpList2;
        
    }
    

}