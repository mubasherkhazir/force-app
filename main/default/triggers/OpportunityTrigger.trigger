trigger OpportunityTrigger on Opportunity (before insert,after insert, before update,after update,before delete,after delete) {
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        OpportunityHelper.updateOpportunity(Trigger.newMap);       
    }
    
    
    
    
    // BEFORE INSERT
    if(Trigger.isInsert && Trigger.isBefore){
        OpportunityHelper.closeDateChecker(Trigger.new);
        OpportunityHelper.stopUpdatingOpportunities(Trigger.new);
    }
    //AFTER INSERT
    if(Trigger.isInsert && Trigger.isAfter){
        OpportunityHelper.addContactRole(Trigger.newMap);
        
    }
    //BEFORE UPDATE
    
    if(Trigger.isUpdate && Trigger.isBefore){       
        OpportunityHelper.stopUpdatingOpportunities(Trigger.new);
        
        
        if(CampaignTriggerHelper.flag)
        {
            OpportunityHelper.alertOnClose(Trigger.new);
        }
    }
    
//AFTER UPDATE
if(Trigger.isUpdate && Trigger.isAfter){
OpportunityHelper.incrementProducts(Trigger.newMap);

if(OpportunityHelper.flag){
OpportunityHelper.flag=false;
 OpportunityHelper.opportunityClone(Trigger.newMap);

}
}

}