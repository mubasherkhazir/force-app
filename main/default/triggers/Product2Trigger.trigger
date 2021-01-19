trigger Product2Trigger on Product2 (before insert,after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        ProductTriggerHelper.priceBookEntry(Trigger.newMap);
    }
}