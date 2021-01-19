public class ContentDocumentLinkTriggerHelper {
    public static void createShareableLink(Map<id,ContentDocumentLink> newMap){
        Set<ID> conId=newMap.KeySet();
        System.debug(newMap);
        System.debug('conId in cdLink'+conID);
        
        
        Set<id> contentId=new  Set<id>();
        set<id> entityId=new  Set<id>();
        for(ContentDocumentLink c:newMap.values()){
            contentId.add(c.ContentDocumentid);
            entityId.add(c.LinkedEntityId);
            
        }
        
        try{
            ContentVersion cv = [select id from contentversion where ContentDocumentid in :contentId];
            ContentDistribution cd = new ContentDistribution();
            cd.Name = 'Test';
            cd.ContentVersionId = cv.id;
            cd.PreferencesAllowViewInBrowser= true;
            cd.PreferencesLinkLatestVersion=true;
            cd.PreferencesNotifyOnVisit=false;
            cd.PreferencesPasswordRequired=false;
            cd.PreferencesAllowOriginalDownload= true;
            insert cd;
            
            ContentDistribution cdnew=[SELECT Id, Name, DistributionPublicUrl 
                                       FROM ContentDistribution where ContentDocumentId =:contentId limit 1];
            Account acct=[select id,Name,Description from Account where id =:entityId ];
            System.debug(cdnew.DistributionPublicUrl);
            acct.Description=cdnew.DistributionPublicUrl;
            update acct;
        }
        Catch(Exception e){
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
        }        
        
        
    }
    
}