public class InsertOpportunitiesApex {
    
    public class WrapperOpp {
        public String Name{get;set;}
        public Date CloseDate{get;set;}
        public String StageName{get;set;}
        public String AccountId{get;set;}
    }
    
    
    @AuraEnabled
    public static List<String> getStageName(){
        List<String> stageNames=new List<String>();
        Schema.SObjectType opp=Schema.getGlobalDescribe().get('Opportunity');
        Schema.DescribeSObjectResult res=opp.getDescribe();
        Schema.DescribeFieldResult fieldResult=res.fields.getMap().get('StageName').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            stageNames.add(pickListVal.getLabel());
        }     
        return stageNames;
    }
    @AuraEnabled
    public static boolean insertOpportunitiesList(String obj){
        
        List<WrapperOpp> opWrap= (List<WrapperOpp>)System.JSON.deserialize(obj,List<WrapperOpp>.class);
        List<Opportunity> opList=new List<Opportunity>();
        for(WrapperOpp wp:opWrap){
            Opportunity opp=new Opportunity();
            opp.Name=wp.Name;
            opp.CloseDate=wp.CloseDate;
            opp.StageName=wp.StageName;
            opp.AccountId=wp.AccountId;
            opList.add(opp);
        }
        
        if(!opList.isEmpty()){
            insert opList;
            return true;
        }
        else{
            return false;
        }
        
        /*List<Opportunity> oppList = (List<Opportunity>) JSON.deserialize(obj, List<Opportunity>.class);
System.debug(oppList);
if(!oppList.isEmpty())
{
insert oppList;
return true;
}
else
return false;        
*/
    }
    
}