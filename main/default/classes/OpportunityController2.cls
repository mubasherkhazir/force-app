public class OpportunityController2 {
    public boolean flag{
        get; set;
    }
    public opportunity opp{get;set;}
    
    
    
    public OpportunityController2(ApexPages.StandardController controller)
    {
        // flag=true;
        // opp= (opportunity) controller.getRecord();
    }
    
    
    public String selectedOpportunity{set; get;}
    
    public String getSelectedOpportunities()
    {
        return selectedOpportunity;
    }
    public void setSelectedOpportunities(String sel)
    {
        selectedOpportunity=sel;
    }
    public List<SelectOption> oporList;
    public List<SelectOption> getOpportunities () {
        
        if (oporList == null) {
            List<Opportunity> opport = [select id, name,AccountId from Opportunity ];
            oporList = new List<SelectOption>();
            for (Opportunity o : opport) {
                oporList.add(new SelectOption(o.id, o.name ));
            }
        }
        return oporList;
    }
    
    
    public  PageReference test()
    {
        opp=new Opportunity();
        if(selectedOpportunity!=null){
            Opportunity opporu=[select id,Name,StageName from Opportunity where id =:selectedOpportunity];
            System.debug('stage name '+opporu.StageName);
            if(opporu.StageName=='CLOSED WON')
            {
                flag= true;
            }
            else
            {
                flag=false;
            }
        }
        system.debug('flag ='+flag);
        return null;
        
    }
    
    
    
    
}