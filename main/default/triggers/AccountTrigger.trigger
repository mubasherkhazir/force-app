trigger AccountTrigger on Account (before insert,after insert,before update,after update, before delete, after delete) {
   
    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHelper.createEveryThing(Trigger.newMap);
        AccountTriggerHelper.createContacts(Trigger.new);
        AccountTriggerHelper.autoCreateConOpp(Trigger.newMap,Trigger.oldMap);
        //AccountTriggerHelper.createOrder(Trigger.newMap);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter){
        //AccountTriggerHelper.updateEmployee(Trigger.newMap, Trigger.oldMap,Trigger.new);
       // AccountTriggerHelper.createCase(Trigger.newMap,Trigger.oldMap);
       // AccountTriggerHelper.autoCreateConOpp(Trigger.newMap,Trigger.oldMap);
       
        
    }
    if(Trigger.isUpdate && Trigger.isBefore){
       // if(AccountTriggerHelper.flag2)
       //AccountTriggerHelper.createShareableLink(Trigger.newMap);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        AccountTriggerHelper.changeOpportunityParent(Trigger.oldMap);
        
    }
}