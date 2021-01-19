@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    public static void testLead(){
         String CRON_EXP = '0 0 0 15 3 ? 2022';
        List<Lead> leadList=new List<Lead>();
        for(integer i=0;i<200;i++){
            Lead ld=new Lead();
            ld.LastName='my lead';
            ld.Company='Tech';
            leadList.add(ld);
        }
        insert leadList;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
                                       CRON_EXP, 
                                       new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.
        
        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        // Now that the scheduled job has executed,
        // check that our tasks were created
       
    }
}