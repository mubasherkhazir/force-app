trigger PlanTrigger on Plan__c (before insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        PlanTriggerHelper.stopCreatingPlans(Trigger.new);
    }

}