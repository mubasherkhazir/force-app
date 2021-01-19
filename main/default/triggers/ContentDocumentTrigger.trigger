trigger ContentDocumentTrigger on ContentDocument (before insert,after insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
      // ContentDocumentTriggerHelper.createShareableLink(Trigger.newMap);
    }

}