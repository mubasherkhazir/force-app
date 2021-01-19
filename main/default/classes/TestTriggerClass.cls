public class TestTriggerClass {
    
    public static void campaignTest(Map<ID,Campaign> mapCampaign){
        
        set<ID> campID=mapCampaign.keySet();
        
        list<Campaign> campList=[SELECT ID,(SELECT ID,EMAIL FROM CAMPAIGNMEMBERS),(SELECT ID,NAME FROM OPPORTUNITIES WHERE ISWON=TRUE) FROM CAMPAIGN where id in:campID];
        for(Campaign camp:campList){
            system.debug('');
        }
        
        
        
    }

}