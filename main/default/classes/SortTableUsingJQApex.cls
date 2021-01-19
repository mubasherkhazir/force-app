public class SortTableUsingJQApex{
    @AuraEnabled
    public static List<Account> getAccountList(){
        
        return [SELECT Id, Name, Phone,NumberOfEmployees, AccountNumber FROM Account limit 20];
    }
    
    @AuraEnabled
    public static List<Account> getSortedList(Boolean flags){
        
        if(!flags){
            return [SELECT Id, Name, Phone,NumberOfEmployees, AccountNumber FROM Account ORDER BY Name ASC LIMIT 20];
            
        }
        else
        {
            return [SELECT Id, Name, Phone,NumberOfEmployees, AccountNumber FROM Account ORDER BY Name desc LIMIT 20];
            
        }
    }
    
}