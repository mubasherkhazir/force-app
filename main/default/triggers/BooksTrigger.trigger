trigger BooksTrigger on Books__c (before insert,after insert,before update,after update){
    
    if(Trigger.isInsert && Trigger.isAfter || Trigger.isUpdate && Trigger.isAfter)
    {
        if(BooksTriggerHelper.flag){
        BooksTriggerHelper.flag=false;
        BooksTriggerHelper.priceDiscount(Trigger.newMap);

        }
    }   
    
    if(Trigger.isInsert && Trigger.isAfter){
        
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        
    }

}