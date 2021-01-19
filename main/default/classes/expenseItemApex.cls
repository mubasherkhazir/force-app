public class expenseItemApex {
@AuraEnabled
    public static Expense__c getExpense(){
        
        return [SELECT Id, Name, Amount__c, Client__c, Date__c, Reimbursed__c FROM Expense__c limit 1 ];
    }
    
    @AuraEnabled 
    public static void saveExpense(Expense__c expense){
        insert expense;
    }
}