@isTest
public class SumTotalAmount_TestClass {

    @isTest
    public static void sumTest(){
        Financial_Account__c fa=new Financial_Account__c();
        fa.Name='finance';
        insert fa;
        
        Receivables__c rc=new Receivables__c();
        rc.Name='recievables';
        rc.Financial_Account__c=fa.Id;
        rc.Total_Amount__c=23000;
        insert rc;
        
        SumTotalAmount.sumAmount();
    }
}