@isTest
public class ContentDocumentLinkTriggerHelper_Test {
    
    @isTest
    public static void testAttach(){
        string attach = 'Testing base 64 encode';            
        Blob blobAttach = Blob.valueOf(attach);
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData =blobAttach;          
        insert cv;  
        
        System.debug('cv '+cv.ContentDocumentId);
    }
}