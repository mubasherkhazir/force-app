/*
Created By : Utkarsh Maurya
Created Date: 29-Apr-2020
Description: Used to capture Images and to draw on the captured Image
*/

public class ImageCaptureClass{
    
    public date currentDate{get;set;} //set today's date to input fields
    public String selectedShape{get; set;} //default selected shape in shape select list
    public list<SelectOption> shapeSelectList{get;set;} //stores all the drawable shapes
    public Integer thickness{get;set;} //set thickness of drawable shape
    public String color{get;set;} //set color of drawable shape
    public Boolean isMobile{get;set;} // hide/show UI for Mobile users
    public static String recordId{get; set;} //store the current recordID/ParentId
    public String salesforceTheme{get;set;} //store whether the VF page is running on Mobile or PC
    
    
    //*****Constructor to assign default values to VF page(Start)*****//
    public ImageCaptureClass(ApexPages.StandardController controller){
        try{
            
            currentDate = Date.today();
            thickness = 1;
            color = '#FF0000';
            
            shapeSelectList = new list<SelectOption>();
            shapeSelectList.add(new SelectOption('line','line'));
            shapeSelectList.add(new SelectOption('circle','circle'));
            shapeSelectList.add(new SelectOption('straight line','straight line'));
            shapeSelectList.add(new SelectOption('polygon','polygon'));
            shapeSelectList.add(new SelectOption('rectangle','rectangle'));
            shapeSelectList.add(new SelectOption('arrow','arrow'));
            
            isMobile = false;
            salesforceTheme = UserInfo.getUiTheme();
            if(salesforceTheme == 'Theme4t')
                isMobile = true;
            
            recordId = controller.getRecord().id;
            
        }catch(exception e){
            system.debug('Error message:::'+e.getMessage()+'--->Line Number::::'+e.getLineNumber());
        }
    }
    //*****Constructor to assign default values to VF page(End)*****//
    
    
    
    
    //*****Method to Stored Images and Insert QSA record(Start)*****//
    @RemoteAction
    public static Boolean getStoreImage(List<String> imageList,List<String> noteList,String dataString){
        try{
            
            Quality_Site_Assessment__c qsaInstance = new Quality_Site_Assessment__c();
            if(String.isNotBlank(dataString))
                qsaInstance = (Quality_Site_Assessment__c)JSON.deserialize(dataString, Quality_Site_Assessment__c.class);
            insert qsaInstance;
            
            System.debug(imageList.size());
           
            if(imageList.size() > 0){
                
                List<ContentVersion> contentVersionList = New List<ContentVersion>();
                
                for(integer i=0; i<imageList.size(); i++){
                    Blob blobAttach = Blob.valueOf(imageList[i]);
                    ContentVersion ContVerFile = new ContentVersion();
                    ContVerFile.VersionData = blobAttach;
                    ContVerFile.Title = 'title_New'; 
                    ContVerFile.ContentLocation= 's';
                    ContVerFile.PathOnClient='title.png';
                    ContVerFile.Description = noteList[i];
                    contentVersionList.add(ContVerFile);
                }
                
                insert contentVersionList;
                
                List<Id> contentDocumentIdList = New List<Id>();
                
                for(ContentVersion cv : [SELECT ContentDocumentId FROM ContentVersion WHERE id In: contentVersionList]){
                    contentDocumentIdList.add(cv.ContentDocumentId);
                }
                
                List<ContentDocumentLink> contentDocumentLinkList = New List<ContentDocumentLink>();
                for(id cvId : contentDocumentIdList){
                    ContentDocumentLink cDe = new ContentDocumentLink();
                    cDe.ContentDocumentId = cvId;
                    cDe.LinkedEntityId = qsaInstance.Id;
                    cDe.ShareType = 'I';
                    cDe.Visibility = 'AllUsers';
                    contentDocumentLinkList.add(cDe);
                }
                insert contentDocumentLinkList;
                
                List<Quality_Site_Assessment_Note__c> qualitySiteAssessmentNoteList = New List<Quality_Site_Assessment_Note__c>();
                
                for(integer i=0; i<contentVersionList.size(); i++){
                    Quality_Site_Assessment_Note__c qsaNote = New Quality_Site_Assessment_Note__c();
                    qsaNote.Image_Data__c = contentVersionList[i].id;
                    qsaNote.Note__c = noteList[i];
                    qsaNote.QSA_Name__c = qsaInstance.id;
                    qualitySiteAssessmentNoteList.add(qsaNote);
                }
                insert qualitySiteAssessmentNoteList;
                
            }
            return true;
        }catch(exception e){
            system.debug('Error message:::'+e.getMessage()+'--->Line Number::::'+e.getLineNumber());
            return false;
        }
    }
    //*****Method to Stored Images and Insert QSA record(End)*****//
    
    
    
    
    //*****Method to Get Images related to current RecordID/ParentID(Start)*****//
    @AuraEnabled
    public static List<ContentVersion> getImagesList(String recordId){
        try{
            set<Id> contentDocumentIdSet = New Set<id>();
            List<ContentDocumentLink> contentDocumentLinkList = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId=:recordId];
            for(ContentDocumentLink cdl: contentDocumentLinkList){
                contentDocumentIdSet.add(cdl.ContentDocumentId);
            }
            
            List<ContentVersion> contentVersionList = [SELECT id,Description,CreatedDate FROM ContentVersion WHERE ContentDocumentId In: ContentDocumentIdSet order by CreatedDate desc];
            return contentVersionList;
            
        }catch(exception e){
            system.debug('Error message:::'+e.getMessage()+'--->Line Number::::'+e.getLineNumber());
            return null;
        }
    }
    //*****Method to Get Images related to current RecordID/ParentID(End)*****//
    
}