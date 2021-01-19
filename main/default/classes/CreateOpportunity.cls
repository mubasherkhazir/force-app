public class CreateOpportunity {
    
    public static Opportunity createOpportunity(String Name,ID accID){
        Opportunity opportuntiy=new Opportunity();
        opportuntiy.Name=Name;
        if(accID !=NULL)
        opportuntiy.AccountId=accID;
        opportuntiy.CloseDate=System.today() +30;
        opportuntiy.StageName='New';
        return opportuntiy;
        
    }

}