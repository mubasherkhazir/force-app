trigger PropertyTrigger on Property__c (before insert,after insert)
{

    if(Trigger.isInsert && Trigger.isAfter){
        UpdateContactAcquisition.updateContact(Trigger.newMap);
    }
}