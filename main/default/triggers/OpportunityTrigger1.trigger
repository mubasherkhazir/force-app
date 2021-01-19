trigger OpportunityTrigger1 on Opportunity (before insert,before update,after update) {
    if(Trigger.isUpdate && Trigger.IsAfter){
        OpportunityTriggerHelper.cloneOpportunity(Trigger.newMap);
        
    }
}