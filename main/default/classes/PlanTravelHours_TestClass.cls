@isTest
public class PlanTravelHours_TestClass {

    @isTest
    public static void testTotalHours(){
        Plan__c plan=new Plan__c();
        plan.Travel_Hours__c=50;
        plan.Travel_Location__c='A;B;F';
        insert plan;
        
        PlanTravelHours.totalHours();
    }
    @isTest
    public static void testTotalHours1(){
        Plan__c plan=new Plan__c();
        plan.Travel_Hours__c=50;
        insert plan;
        
        PlanTravelHours.totalHours();
    }
    @isTest
    public static void stopCreatingPlansTest(){
        Try{
            Plan__c plan=new Plan__c();
        plan.Travel_Hours__c=50;
        plan.Travel_Location__c='A';
        insert plan;
        
        Plan__c plan1=new Plan__c();
        plan1.Travel_Hours__c=50;
        plan1.Travel_Location__c='B';
        insert plan1;
        
        Plan__c plan2=new Plan__c();
        plan2.Travel_Hours__c=50;
        plan2.Travel_Location__c='A';
        insert plan2;
        
        Plan__c plan3=new Plan__c();
        plan3.Travel_Hours__c=50;
        plan3.Travel_Location__c='A';
        insert plan3;
        }
        Catch(Exception e){
            System.debug('Error Occured');
        }        
    }
}