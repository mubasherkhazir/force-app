public with sharing class ContentDocumentTriggerHelper {
    
    public static void createShareableLink(Map<id,ContentDocument> newMap){
        Set<ID> conId=newMap.KeySet();
        System.debug(newMap);
        System.debug('conId '+conID);
        
        try{
           
       
        ContentDocumentLink files2=[SELECT ContentDocumentID, LinkedEntity.type, LinkedEntityId 
                                    FROM ContentDocumentLink 
                                    WHERE ContentDocumentID =:conId and LinkedEntityId !=NULL limit 1];
        
        System.debug(files2);
        ContentVersion cv = [select id from contentversion where ContentDocumentid =:files2.ContentDocument.id];
        ContentDistribution cd = new ContentDistribution();
        cd.Name = 'Test';
        cd.ContentVersionId = cv.id;
        cd.PreferencesAllowViewInBrowser= true;
        cd.PreferencesLinkLatestVersion=true;
        cd.PreferencesNotifyOnVisit=false;
        cd.PreferencesPasswordRequired=false;
        cd.PreferencesAllowOriginalDownload= true;
        upsert cd;
        
        ContentDistribution cdnew=[SELECT Id, Name, DistributionPublicUrl 
                                 FROM ContentDistribution where ContentDocumentId=:files2.ContentDocument.id limit 1];
        Account acct=[select id,Name,Description from Account where id =:files2.linkedentityid ];
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