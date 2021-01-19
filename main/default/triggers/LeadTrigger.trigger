trigger LeadTrigger on Lead (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        LeadTriggerHelper.createOpportunity(Trigger.newMap);
    }

}