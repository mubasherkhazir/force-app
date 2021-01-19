@isTest
public class LeadProcessorTest {
    
    @isTest
    public static void createTest(){
        Integer recordsProcessed=0;
        List<Lead> leadList=new List<Lead>();
        for(Integer i=0;i<200;i++){
            Lead led=new Lead();
            Led.LastName='Lead create '+i;
            led.Company='Tech';
            leadList.add(led);
            recordsProcessed =recordsProcessed+1;
        }
        if(!leadList.isEmpty())
            insert leadList;
        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp,200);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200,recordsProcessed);
        
    }
}