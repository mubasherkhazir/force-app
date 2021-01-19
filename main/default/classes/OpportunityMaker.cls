@isTest
public class OpportunityMaker {
    
    public static List<Opportunity> createOpportunity(){
        
        List<Account> accList=AccountMaker.makeAccounts();
        
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=0;i<10;i++){
            Opportunity opp = new Opportunity();
            opp.CloseDate=date.today().addMonths(2);
            opp.AccountId=accList[i].id;
            opp.Name='test opp';
            opp.StageName='Closed Won';
        }
        
        if(!oppList.isEmpty()){
            insert oppList;
        }
        
        return oppList;
    }
}