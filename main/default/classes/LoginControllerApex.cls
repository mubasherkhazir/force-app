public class LoginControllerApex {
    @AuraEnabled
    public static Boolean getDetails(String username, String password){
        
        if(username==NULL)
            //return 'Please Enter a UserName';
        return false;
        
      List<Login_Users__c> LoginList=[Select Id,Username__c,Password__c from Login_Users__c where Username__c =: username Limit 1];
            
        
        
        if(LoginList.isEmpty())
        {
            //return 'No Username found'; 
            return false;
        }
        else
        {
            if(LoginList[0].Password__c.equals(password))
            {
                //return 'Welcome! Logged in.';
                return true;
            }
            else
            {
                //return 'Oops sorry! Wrong password';
                return false;
            }
            
        }
    }
}