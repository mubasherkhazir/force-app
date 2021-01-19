public class OpportunityController {
    public  string ids;
    public static string oid{set; get;}
    public static boolean flag{set;get;}
    
    public OpportunityController(){
        flag=false; 
        
    }
    public ApexPages.StandardSetController controller{
        get {
            if(controller == null) {
                controller = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Name,StageName,CloseDate FROM Opportunity]));
            }
            return controller;
        }
        set;
    }
    public List<Opportunity> getOpportunities() {
        return (List<Opportunity>) controller.getRecords();
    }
    public static boolean test{set; get;}
    public PageReference test(){
        oid=ApexPages.currentPage().getParameters().get('oid');
        System.debug('ids '+oid);
        if(oid!=null)
        {
            Opportunity opp=new Opportunity();
            opp=[select id,StageName from Opportunity where id=:oid];
            if(opp.StageName=='CLOSED WON')
            {
                flag= true;
            }
            else
            {
                flag=false;
            }
        }
        return null;
    }
}