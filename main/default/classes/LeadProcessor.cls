global class LeadProcessor implements Database.Batchable<sObject> {
    global Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([select id,Name from Lead]);
    }
    public void execute(Database.BatchableContext bc,List<Lead> record){
        
        for(Lead ld:record){
            ld.LeadSource='Dreamforce';
            recordsProcessed =recordsProcessed+1;
        }
        update record;
    }
    public void finish(Database.BatchableContext bc){
        
        
    }

}