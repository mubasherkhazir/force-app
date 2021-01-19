public class forgetPasswordApexController {
    
    @AuraEnabled
    public static Boolean matchAnswer(String answer,String username, String email){
        List<Login_Users__c> user=[select id,Password__c,Name,Username__c,Answer__c from Login_Users__c where Username__c =:username OR Contact_email__c =:email limit 1];
        if(!user.isEmpty()){
            if(user[0].Answer__c==answer){
                return true;
            }else
            {
                return false;
            }
            
        }
        else
        {
            return false;
        }
        
    }
    
    @AuraEnabled
    public static String findAccount(String username, String email){
        List<Login_Users__c> user=[select id,Password__c,Name,Username__c from Login_Users__c where Username__c =:username OR Contact_email__c =:email limit 1];
        
        if(!user.isEmpty()){
            return user[0].Username__c;
        }
        else
        {
            return 'Sorry! NO User Found';
        }
        
    }
    
    @AuraEnabled
    public static Boolean resetPassword(String username, String newPassword){
        List<Login_Users__c> user=[select id,Password__c,Name from Login_Users__c where Username__c =:username limit 1];
        
        if(!user.isEmpty()){
           // if(user[0].Password__c==oldPassword)
            {
                user[0].Password__c=newPassword;
                
                update user;
                return true;
            }
           /* else{
                return false;
            } */
        }
        else
        {
            return false;
        }
        
    }    
    
}