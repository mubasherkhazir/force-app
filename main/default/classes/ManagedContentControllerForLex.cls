public class ManagedContentControllerForLex{
    
    @AuraEnabled
    public static List<ConnectApi.ManagedContentVersion> getMContent(String contentType, String managedContentIds_str, String topicNames_str, String language) {
        List<String> contentIds = new List<String>();
        List<String> topicNames = new List<String>();
        try{
            if(managedContentIds_str != null && !String.isEmpty(managedContentIds_str)){
                contentIds = managedContentIds_str.split(',',-1);
            }
            
            for(Integer i=0;i<contentIds.size();i++){
                contentIds.set(i,contentIds.get(i).trim());
            }
            
            if(topicNames_str != null && !String.isEmpty(topicNames_str)){
                topicNames = topicNames_str.split(',',-1); 
            }
            
            for(Integer i=0;i<topicNames.size();i++){
                topicNames.set(i,topicNames.get(i).trim());
            }
            String communityId = '0DB2w0000004EYWGA2';//Network.getNetworkId();
            
            language = 'en_US';
            ConnectApi.ManagedContentVersionCollection contentCollection = null;
            //contentCollection = ConnectApi.ManagedContent.getManagedContentByTopicsAndIds(communityId, contentIds, topicNames, 0, 25, language, contentType);
            contentCollection =ConnectApi.ManagedContent.getAllManagedContent(communityId, 0, 25, language, contentType);
            system.debug('>>>>>>>>>>>>>> '+contentCollection);
          
            
       return contentCollection.items;

            
        }
        catch(ConnectApi.ConnectApiException e){
            System.debug('Error Message : '+e);
            ApexPages.addMessages(e);
            List<ConnectApi.ManagedContentVersion> mcvList = new List<ConnectApi.ManagedContentVersion>();
            return mcvList;
        }
    }
    
    @AuraEnabled
    public static List <String> getPiklistValues(){
        List<String> plValues = new List<String>();
         
        //Get the object type from object name. Here I've used custom object Book.
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Account');
         
        //Describe the sObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
         
        //Get the specific field information from field name. Here I've used custom field Genre__c of Book object.
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Industry').getDescribe();
         
        //Get the picklist field values.
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
         
        //Add the picklist values to list.
        for(Schema.PicklistEntry plv: picklistvalues) {
            plValues.add(plv.getValue());
        }
        plValues.sort();
        return plValues;
        
    }
    
}