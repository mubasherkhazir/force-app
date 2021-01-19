public class LoginApexController {
    
    @AuraEnabled
    public static list<String> getUsers(){
        List<String> userList=new List<String>();
        List<Login_Users__c> lst=[select Username__c from Login_Users__c];
        for(Login_Users__c user:lst){
            userList.add(user.Username__c);
        }
        
        return userList;
    }
    
    @AuraEnabled
    public static void attachImage(String contentId){
        
        
        Login_Users__c user=[select id from Login_Users__c order by createdDate desc limit 1];

        ContentDocumentLink cDe = new ContentDocumentLink();
        cDe.ContentDocumentId = contentId;
        cDe.LinkedEntityId = user.Id;
        cDe.ShareType = 'I';
        cDe.Visibility = 'AllUsers';
        insert cDe;
        
        //List<ContentDocumentLink> cdl=[SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where LinkedEntityId='0052w000003KgjQAAS'];
        //if(!cdl.isEmpty()){
           // delete cdl;
//        }

        
        ContentVersion cv = [select id from ContentVersion where ContentDocumentid =:contentId];
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
        System.debug(cdnew.DistributionPublicUrl);
        
        user.Address_Line_2__c=cdnew.DistributionPublicUrl;
        update user;
    }
}