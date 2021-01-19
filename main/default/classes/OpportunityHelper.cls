public class OpportunityHelper {
    
    /*
* On Opportunity do not let the user insert Opportunities with past
* closed Date with following Message "Please enter a future Closed Date"
for (Contact c : [
select Id, LastName
from Contact
where LastName in :lastNames
]) {
contacts.put(c.LastName, c);
}
*/
    public static void closeDateChecker(List<Opportunity> opportunityList){
        //CampaignTriggerHelper.flag=true;
        Map<String, Opportunity> opportunityMap=new Map<String, Opportunity>();    
        
        for(Opportunity opportunity:opportunityList){
            opportunityMap.put(opportunity.Name,opportunity);
        }
        for(String Name:opportunityMap.keySet()){
            if(opportunityMap.get(Name).CloseDate < DATE.today()){
                opportunityMap.get(Name).addError('Please Enter Future Date');
            }
        }
    }
    
    /*
* On Opportunity to alert the user when an Opportunity is being closed 
* with no Opportunity line items in it.
*/
    
    public static void alertOnClose(List<Opportunity> opportunityList){
        
        Map<DATETIME,OPPORTUNITY> opportunityMap=new Map<DATETIME,OPPORTUNITY>();
        for(Opportunity opportunity:opportunityList){
            opportunityMap.put(DATETIME.now(),opportunity);
        }
        
        System.debug('Opportunity Map >>>>> '+opportunityMap);
        
        for(DATETIME dateT:opportunityMap.keySet()){
            if((opportunityMap.get(dateT).hasOpportunityLineItem==false) && (opportunityMap.get(dateT).isClosed==true)){
                opportunityMap.get(dateT).addError('CAN\'T CLOSE WITHOUT HAVING AN OPPORTUNITY LINE ITEM');
            }
        }
        
    }
    
    /*
* "Added: ""Create an integer field ""No Of Products sold"" in Product standard object.
*  Write a Trigger on Opportunity to increment the Product ""No of product sold"" with
*  each Opportunity lineitem when the opportunity is getting closed Won. ""
* 
*/
    public static void incrementProducts(MAP<ID,OPPORTUNITY> opportunityMap){
        
        Set<ID> opportunityID=new Set<ID>();
 
        try{
            
            for(ID opporID:opportunityMap.keySet()){
                if(opportunityMap.get(opporID).hasOpportunityLineItem && opportunityMap.get(opporID).isWon)
                    opportunityID.add(opporID);
                
            }
            System.debug('OpportunityID closed one and has line items >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '+opportunityID);
            
            
            /**************************************************************************************************************************/
            
            Map<ID, List<OpportunityLineItem>> opportunityLineItemsMap = new Map<ID, List<OpportunityLineItem>>();
            
            for (Opportunity oppty : [SELECT Id, Name, (SELECT Id, Product2.Name,Product2.ID,Product2.No_Of_Products_sold__c FROM OpportunityLineItems) FROM Opportunity WHERE Id =: opportunityID])
            {
                opportunityLineItemsMap.put(oppty.Id, oppty.OpportunityLineItems);
            }
            
            System.debug('OpportunityLine Items Map  '+opportunityLineItemsMap);
        
        
            System.debug('OpportunityLine Items Map values  '+opportunityLineItemsMap.values());
            List<Product2> prodlist=new List<Product2>();
            for(ID opp:opportunityLineItemsMap.keySet() )
            {
                List<OpportunityLineItem> opporLineItem=opportunityLineItemsMap.get(opp);
                for(opportunityLineItem oli:opporLineItem){
                    if(oli.Product2.No_Of_Products_sold__c ==NULL){
                        oli.Product2.No_Of_Products_sold__c=0;  
                    } 
                    oli.Product2.No_Of_Products_sold__c +=1; 
                    prodList.add(oli.Product2);
                }
            }
            //update prodList;
        
        }
        Catch(Exception e){
            System.debug('Exception in product increment '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
         /////////////////////// 2ND APPROACH without using nested query//////////////////////////////////////////////   
           
            Map<ID, List<OpportunityLineItem>> opportunityLineItemsMap1 = new Map<ID, List<OpportunityLineItem>>();
            List<OpportunityLineItem> oli2=[SELECT Id,OpportunityID, Product2.Name,Product2.ID,Product2.No_Of_Products_sold__c FROM OpportunityLineItem WHERE OpportunityID =: opportunityID];
            
            for(OpportunityLineItem oli:oli2){
               
                if(opportunityLineItemsMap1.containsKey(oli.OpportunityId)){
                    opportunityLineItemsMap1.get(oli.OpportunityId).add(oli);
                }
                else{
                    opportunityLineItemsMap1.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
                    
                }
                
                
            }
             System.debug('OpportunityLine Items Map 2  '+opportunityLineItemsMap1);
            
            
            //////////////////////////////////////////////////////////////////////////////////////////////////////////
               
        
            /******************************************************************************************************************/
             // 3rd APPROACH 
            /***************************************************************************************************************************/
           
        try{
            
                    Map<ID,OPPORTUNITYLINEITEM> opportunityLineMap=new Map<ID,OPPORTUNITYLINEITEM>([SELECT ID,NAME,PRODUCT2ID,OPPORTUNITYID,QUANTITY,UNITPRICE FROM OPPORTUNITYLINEITEM WHERE PRODUCT2ID!=NULL AND  OPPORTUNITYID IN :opportunityID LIMIT 500]);

            System.debug('OpportunityLineItem >>>>>>>>>>>>>>>>>>>>>>>>>>>> '+opportunityLineMap);
           /*
             Set<ID> prodID=new Set<ID>();
            
            for(ID oli:opportunityLineMap.keySet()){
                prodID.add(opportunityLineMap.get(oli).product2id);
            }
            
            System.debug('Product2ID >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '+prodID);
            
             MAP<ID,PRODUCT2> product2Map=new MAP<ID,PRODUCT2>([SELECT ID,NAME,No_Of_Products_sold__c FROM PRODUCT2 WHERE ID IN :prodID limit 500]);
            
              System.debug('Product2Map>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> '+product2Map);
            
              for(ID prod:product2Map.keySet()) */
                for(OpportunityLineItem oli:opportunityLineMap.values())
                {
                    Product2  prod=new product2(id=oli.Product2Id);
                    if(prod.No_Of_Products_sold__c==NULL)
                    {
                        prod.No_Of_Products_sold__c=0;
                    }
                      prod.No_Of_Products_sold__c +=1;
                      System.debug('Product name '+prod.Name +' product sold '+prod.No_Of_Products_sold__c);

                    //TRIED TO MINIMIZE 2ND FOR LOOP BY USING THE ABOVE APPROACH. 
                    
                     /* if(prod==opportunityLineMap.get(oli).product2id)
                     {
                        if(product2map.get(prod).No_Of_Products_sold__c==NULL){
                            product2map.get(prod).No_Of_Products_sold__c=0;
                        }
                        product2map.get(prod).No_Of_Products_sold__c +=1;
                        System.debug('Inside prod increment loop');
                    } */
                }
            update opportunityLineMap.values();
           // if(!product2map.isEmpty())
                // update product2map.Values();
            
            
        }
        Catch(Exception e){
            System.debug('Exception found in increment products method at line no '+e.getLineNumber());
            System.debug(e.getMessage());
        }
 
    }

    
    /*
* 
* "Create a trigger on Opportunity to add all the Contacts having the same Account as Opportunity.
* Account into the Opportunity ""Contact Roles" " Example:- Account: Birla have 3 Contacts: 
* ajay,amar,anuj Then while creating an Opportunity for Birla add ajay,amar & anuj to Opportunity Contact roles--T"  
* 
*/ 
    public static void addContactRole(Map<ID,OPPORTUNITY> opportunityMap){
        Set<ID> accountID = new Set<ID>();
        for(ID oppID:opportunityMap.keySet()){
            if(opportunityMap.get(oppID).AccountID !=NULL){
                accountID.add(opportunityMap.get(oppID).AccountID);
            }
        }        
        Map<ID,List<Contact>> accountContMap=new Map<ID,List<Contact>>();
        for(Account account:[select id,name,(select id,firstName,Lastname from contacts) from Account where Id in :accountID limit 5000]){
            
            accountContMap.put(account.id,account.Contacts);
            
            /* List<Contact> contList=new List<Contact>();
for(ID opprId :opportunityMap.keySet()){
        if(opportunityMap.get(opprId).AccountID==account.Id){
OpportunityContactRole OCR=new OpportunityContactRole();
//OCR.ContactId=accountContMap.get(account).contacts.id;

}
} */
            
        }
        List<OpportunityContactRole> ocrList=new List<OpportunityContactRole>();
        for(Opportunity op:opportunityMap.values()){
            //for (ID opppId :opportunityMap.keySet()){
            //opportunity op = opportunityMap.get(opppId);
            if(op.AccountId!=NULL){
                List<Contact> conList=accountContMap.get(op.accountid);
                for(Contact contact:conList)
                {
                    OpportunityContactRole OCR=new OpportunityContactRole();
                    OCR.ContactId=contact.id;
                    OCR.OpportunityId=op.Id;
                    ocrList.add(OCR);
                }
                
            }
        }
        
        if(!ocrList.isEmpty())
            insert ocrList;
        
        /*for(ID accID:accountContMap.keySet()){
List<Contact> conList=accountContMap.get(accID);
for(Contact contact:conList){
OpportunityContactRole OCR=new OpportunityContactRole();
OCR.ContactId=contact.id;
}


} */
        
        
        System.debug('Account Contact Map ..>>>>>>>>>>>'+accountContMap);
        
        
    }
    
    /*
* Write a code to clone(copy ) 1 Opportunity with all Opportunity line items into a new Opportunity
*  with Closed Date = Old closed date + 30 days & Opportunity name = Opportunity Name+ 'Clone'
*/
    public static boolean flag = true;
    public static void opportunityClone(MAP<ID,OPPORTUNITY> OpportunityMap){
        
        List<Opportunity> opportunityCloneList=new List<Opportunity>();
        
        Set<ID> opportunityID=new Set<ID>();
        try{
            for(Opportunity opportunity:OpportunityMap.Values()){
                
                if(opportunity.HasOpportunityLineItem)
                {
                    opportunityID.add(opportunity.Id);
                    Opportunity opportunityClone=opportunity.clone(false,false,false);
                    opportunityClone.Name=opportunity.Name + ' clone';
                    opportunityClone.CloseDate=opportunity.CloseDate.addDays(30);
                    opportunityCloneList.add(opportunityClone);
                }
                else
                {
                    
                    Opportunity opportunityClone=opportunity.clone(false,false,false);
                    opportunityClone.Name=opportunity.Name + ' clone + N';
                    opportunityClone.CloseDate=opportunity.CloseDate.addDays(30);
                    opportunityCloneList.add(opportunityClone);
                }
            }
            if(!opportunityCloneList.isEmpty())
                insert opportunityCloneList;
            
        } Catch(Exception e){
            System.debug('Exception in opportinity clone '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        Map<ID,OPPORTUNITYLINEITEM> oliMap=new Map<ID,OPPORTUNITYLINEITEM>([select id,Name,OpportunityID,PricebookEntryId,Product2ID,UnitPrice,Quantity from OPPORTUNITYLINEITEM where OpportunityID IN : opportunityID limit 500]);
        System.debug('OPPortuity line item map value '+oliMap);
        try{
            
            List<OPPORTUNITYLINEITEM> oliCloneList = new List<OPPORTUNITYLINEITEM>();
            for(OPPORTUNITYLINEITEM oli:oliMap.values()){
               system.debug('inside for loop Opportunity line item oli '+oli);
              
               //Opportunity opportunity=new Opportunity(id=oli.OpportunityId);
               //THE ABOVE CASE WON'T WORK HERE AS I NEED THE CLONE OPPORTUNITY ID HERE.
               //OTHERWISE I COULD'VE MINIMIZED ONE FOR LOOP HERE. 
               
               for(Opportunity opportunity:opportunityCloneList){
                   {
                       system.debug('OPPORTUNITY ID INSIDE FOR LOOP ');
                       OPPORTUNITYLINEITEM oliClone=oli.clone(false,false);
                       oliClone.OpportunityId=opportunity.Id;
                      // oliClone.Quantity=oli.Quantity;
                       //oliClone.TotalPrice=oli.TotalPrice;
                       //oliClone.Product2Id=oli.Product2Id;
                       //oliClone.PricebookEntryId=oli.PricebookEntryId;
                        oliCloneList.add(oliClone);
                    }
                    
                }
            }
            if(!oliCloneList.isEmpty())
                insert oliCloneList;
            
        } 
        Catch(Exception e){
            System.debug('Exception in opportinity clone '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
    }
    

    //Write a Trigger on Opportunity update to auto-populate Remaining Amount (Total Amount - Amount)
    // where opportunity stage = 'Closed Won'."
    // Amount__c Remaining_Amount__c Total_Amount__c	
    // 
    //     if(Trigger.isUpdate && Trigger.isAfter)

    public static void updateOpportunity(Map<id,Opportunity> opportunityMap)
    {
        set<ID> oppId=opportunityMap.keySet();
       Map<id,Account> accountMap=new  Map<id,Account>([select id,Name,Total_Amount__c,Remaining_Amount__c,(select id,Name,Amount,isWon from
                                        Opportunities) from Account where ID in (Select AccountID from Opportunity where id in:oppID) limit 4500]);
      
        
        System.debug('Account Map >>>>>>>>> '+accountMap);
        
        for(Account account:accountMap.values()){
            Decimal total=0;
            System.debug('account inside loop'+account.Name);            
            List<Opportunity> oppList=account.Opportunities;
            for(Opportunity opportunity:oppList){
                System.debug('Opportunity Name '+opportunity.Name);
                if(opportunity.Amount==NULL)
                    opportunity.Amount=0;
               System.debug('Amount ::'+opportunity.Amount);
                total +=opportunity.Amount;
                  }
            	//Calculating total amount of all the opportunities associated with the account.
               account.Total_Amount__c=total;
            for(Opportunity opportunity:oppList)
            {
                if(opportunity.IsWon)
                {
                    System.debug('Won Opportunity ');
                  if(account.Remaining_Amount__c==NULL)
                      account.Remaining_Amount__c=0;
                    
                  account.Remaining_Amount__c=account.Total_Amount__c-opportunity.Amount;  
                }
            }
            
            
        }
        
        update accountMap.values();
        
        
    }
    //Write a Trigger to stop creating or updating Opportunities with Account having "Working in = ASIA"
 // and Already 2 Closed Won Opportunity under same Account.
 
  
    public static void stopUpdatingOpportunities(List<Opportunity> opportunityList)
    {
        Set<ID> accID=new Set<ID>();
        for(Opportunity opportunity:opportunityList){
            if(Opportunity.AccountId!=NULL)
            accID.add(opportunity.AccountId);
        }
        Map<ID,Account> accountMap=new Map<ID,Account>([select id,Name,(select id,name from Opportunities where isWon=true) 
                                           from Account where Working_in__c='ASIA' AND id in:accID limit 178]);
        System.debug('account map '+accountMap);
        
        for(Account account:accountMap.values()){
            if(account.opportunities.size()>=2){
                for(Opportunity opp:opportunityList){
                    opp.addError('Can\'t insert of Update opportunities already have 2 closed won');
                }
            }
        }
        
        
    }
   
}