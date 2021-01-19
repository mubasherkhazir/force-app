@isTest
public class expenseItemApex_TestClass {
    
    @isTest
    public static void test(){
        Expense__c expense=new Expense__c();
        expense.Amount__c=2400;
        expense.Date__c=System.today();
        expense.Name='good';
        
        expenseItemApex.saveExpense(expense);
        
        expenseItemApex.getExpense();     
    }
}