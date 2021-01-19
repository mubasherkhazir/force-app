/*
 * Create a self lookup on opportunity "Parent Opportunity".Write a trigger on Opportunity. when it's closed.
 *  if the closed opportunity has any opportunity line item then create new opportunity and make closed
 *  opportunity its parent and copy all opportunity line items from parent and create these line items for
 *  newly created opportunity (not delete opportunity line items from parent opportunity).
 */ 


public class OpportunityTriggerHelper {
    
    public static void cloneOpportunity(Map<ID,Opportunity> opportunityMap){
        //// BLOCK 1 ...
        
		Set<ID> opportunityID=opportunityMap.keySet();
        try{
            //NOW GET THE OPPORTUNITIES AND CREATE A COPY OF THEM
            
                Map<ID,Opportunity> recievedOpportunity=new Map<ID,Opportunity>([select id,Name,CloseDate,StageName from Opportunity where isClosed=true AND hasOpportunityLineItem=true AND ID IN:opportunityID]);
           
            Set<ID> newIDs= recievedOpportunity.keySet();    //GET IDS WITH OPPORTUNITYLINEITEMS 

            MAP<ID,OPPORTUNITYLINEITEM> oliMap=	new MAP<ID,OPPORTUNITYLINEITEM>([select id,Quantity,PricebookEntryId,Product2ID,OpportunityID,UnitPrice from OPPORTUNITYLINEITEM where OpportunityID IN :newIDs limit 200 ]);
            System.debug('Data of Opportunites recieved ');
            
            List<Opportunity> cloneOpportunityList =new List<Opportunity>();
            
            
            
            for(Opportunity opportunity:recievedOpportunity.values()){
                
                Opportunity cloneOpportunity=opportunity.clone(false,false,false); //simple cloning, 
                cloneOpportunity.StageName='Qualification';
                cloneOpportunity.Name=opportunity.Name;
                cloneOpportunity.CloseDate=opportunity.CloseDate;
                cloneOpportunity.Parent_Opportunity__c=opportunity.Id;
                cloneOpportunityList.add(cloneOpportunity);
            }
            if(!cloneOpportunityList.isEmpty())
            insert cloneOpportunityList;
            
             List<OPPORTUNITYLINEITEM> oliCloneList= new List<OPPORTUNITYLINEITEM>();
            

            for(Opportunity opportunity:cloneOpportunityList){
                for(OpportunityLineItem oli:oliMap.values()){
                OPPORTUNITYLINEITEM oliClone=oli.Clone(false,false); //simple clone
                oliClone.OpportunityId=opportunity.Id;
                    oliClone.Product2Id=oli.Product2Id;
                    //oli.PricebookEntryId=oli.PricebookEntryId;
                   oliClone.Quantity= oli.Quantity;
                oliCloneList.add(oliClone);
                
            }   
            }
            
            
            
            
            if(!oliCloneList.isEmpty()){
                insert oliCloneList;
            }
            

            
            
            }
            
       Catch(Exception e){
            System.debug('Exeption caught in opportunity helper block 1 '+e.getLineNumber());
            System.debug(e.getMessage());
        }
     
        
        
    }

}