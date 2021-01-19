trigger OfferTrigger on Offer__c (before insert,after insert,after delete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        OfferTriggerHelper.offer();
        
    }
    if(Trigger.isDelete && Trigger.isAfter){
        OfferTriggerHelper.offer();
    }
    
}