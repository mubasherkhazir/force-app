@isTest
public class SortTableUsingJQApex_TestClass {

    @isTest
    public static void createSortTest(){
       List<Account> accList=[select id,Name from Account Limit 10];
       SortTableUsingJQApex.getAccountList();
       SortTableUsingJQApex.getSortedList(true);
        SortTableUsingJQApex.getSortedList(false);
        
    }
}