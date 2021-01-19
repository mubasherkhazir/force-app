public class inlineController {
    
    Public Opportunity opportunityRecord{get;set;}
    Public static  Date closeD;
    Public Integer dateDifference {set; get;}
    
    public inlinecontroller(ApexPages.StandardController controller) {
        String oid= ApexPages.currentPage().getParameters().get('id');
        if( oid != NULL){
            opportunityRecord = [select id,Name,CloseDate from Opportunity where id = :ApexPages.currentPage().getParameters().get('id') limit 1];
            closeD=opportunityRecord.CloseDate;
        }
        
    }
    
    public static Boolean getDateDif(){
        Date td=Date.today();
        if(closeD != NULL){
            if(closeD.year()==td.year() && closeD.month()==td.month()){
                if((closeD.day()-td.day())<=5)
                    return true;
            }   
        }
        
        return false;
        
        
    }
}