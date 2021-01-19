trigger CampaignTrigger on Campaign (before update,after Update) {

    if(Trigger.isUpdate && Trigger.isBefore){

    }
    if(Trigger.isUpdate && Trigger.isAfter){
        CampaignTriggerHelper.closeOpportunities(Trigger.newMap);
        TestTriggerClass.campaignTest(Trigger.newMap);

    }

    
    
}