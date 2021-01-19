trigger ContactTrigger on Contact (before insert, after insert, after update ,before update, before delete, after delete) {
    if(Trigger.isInsert && Trigger.isBefore){
        
    }
        if(Trigger.isInsert && Trigger.isAfter){
            ContactTriggerHelper.changeStatus2(Trigger.newMap);
            ContactTriggerHelper.updateAccountName(Trigger.newMap);
        
    }
        if(Trigger.isDelete && Trigger.isAfter){
            ContactTriggerHelper.deleteLastName(Trigger.oldMap);
        }
    
    
}