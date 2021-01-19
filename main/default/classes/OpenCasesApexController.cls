public with sharing class OpenCasesApexController {
    
    @AuraEnabled
    public static List<Case> getCasesDB(){
        
        List<String> caseFields =new List<String>{'ID','OwnerId','Type','Status','Priority','isClosed','Reason','Origin'};
        
        Map<String,Schema.SObjectField> caseMap=Schema.SObjectType.Case.fields.getMap();
        for(String field : caseFields){
            System.debug('inside loop');
            if(!caseMap.get(field).getDescribe().isAccessible()){
                System.debug('inside for');
                System.debug('This field is not accessible'+ caseMap.get(field));
                return null;
            }
        }
        
        return[SELECT ID
               FROM CASE
               WHERE ISCLOSED=FALSE
               AND OWNERID=:UserInfo.getUserId()];
    }
    
}