trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert,After insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
       ContentDocumentLinkTriggerHelper.createShareableLink(Trigger.newMap);
    }
}