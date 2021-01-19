trigger QuickLinksTrigger on QuickLinks__c (before insert,after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        QuickLinksTriggerHelper.createHelp(Trigger.newMap);
    }
    

}