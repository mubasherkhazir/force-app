public class DailyLeadProcessor implements Schedulable {
    public void execute(System.SchedulableContext sc){
        
        List<Lead> leadList=[select id,LeadSource from Lead where LeadSource=NULL limit 200];
        
        for(Lead ld:leadList){
            ld.LeadSource='Dreamforce';
            
        }
        update leadList;
    }

}