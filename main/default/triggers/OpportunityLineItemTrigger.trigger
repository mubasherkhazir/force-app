trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert,after insert,before update,after update) {
if (Trigger.isInsert && Trigger.isAfter || Trigger.isUpdate){
        OpportunityLineItemHelper.setRating(Trigger.newMap);
    }
    if (Trigger.isInsert && Trigger.isAfter){
        OpportunityLineItemHelper.incrementLineItems(Trigger.newMap);
    }
    
    
}