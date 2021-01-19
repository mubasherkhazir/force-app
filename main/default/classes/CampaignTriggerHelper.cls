public class CampaignTriggerHelper {
   public static Boolean flag=true;
/*
 * On campaign to close all the opportunities associated with the campaign when campaign status is completed.
 * Example:Opportunities having line itemsin it must be closed won and opportunities having no line item
 * must be closed lost. Send all the details of All associated opportunities.    
 */
    
    public static void closeOpportunities(Map<id,CAMPAIGN> newCampaign){
        flag=false;
        Set<ID> campID=newCampaign.keySet();
        List<Campaign> CampList=[select id from campaign where status='Completed' AND ID IN :campID];
        System.debug('campaign list '+campList);
        
        Map<ID,OPPORTUNITY> opportunityMap=new Map<ID,OPPORTUNITY>([select id,name,StageName,hasOpportunityLineItem from Opportunity where CampaignID in :CampList limit 400]);
        for(Opportunity oppor:opportunityMap.values()){
            if(oppor.hasOpportunityLineItem){
                oppor.StageName='CLOSED WON';
                System.debug('Is won running');
            }
            else
            {
               oppor.StageName='CLOSED LOST'; 
              System.debug('Is lost running');

            }
        }
        update opportunityMap.values();
     
        Map<ID,CampaignMember> CampaignMemberMap=new Map<ID,CampaignMember>([select id,email,CampaignId from campaignMember where campaignID IN :campID limit 15000 ]);
        
        List<Messaging.SingleEmailMessage> mails=new List<Messaging.SingleEmailMessage>();

        for(CampaignMember camp:CampaignMemberMap.Values())
        {
            for(Opportunity oppor:opportunityMap.values()){
                System.debug('Opportunity Name '+oppor.Name);
                Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
                       if(camp.Email!=NULL){
                        List<String> sendTo = new List<String>();
                        sendTo.add(camp.Email);
                        mail.setToAddresses(sendTo);
                        mail.setSenderDisplayName('Salesforce admin');
                        mail.setSubject('Opportunity List');
                        String body = 'List ' + oppor.Name + '. ';
                        mail.setHtmlBody(body);
                        mails.add(mail);
                        System.debug('Email id>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+camp.Email);
            }
            
        }
            }
            
        if(!mails.isEmpty()){
            Messaging.sendEmail(mails);
        }
    
    }
 }