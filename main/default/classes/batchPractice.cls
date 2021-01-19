global class batchPractice implements Database.batchable<sObject>,Database.Stateful{ 

    global Database.QueryLocator start(Database.BatchableContext bc){
        return database.getQueryLocator('SELECT ID,NAME FROM Opportunity where StageName=\'Closed Won\' limit 5000');
    }
    
       List<Opportunity> oppList=new List<Opportunity>();
    global void execute(Database.batchableContext bc,List<Opportunity> acc){
        oppList.addAll(acc);
    }
    
    global void finish(Database.BatchableContext fs){
        System.debug('Opportunity Records Processed >>>> '+oppList);
    }
    
}