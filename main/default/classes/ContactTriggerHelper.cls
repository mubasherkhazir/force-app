public class ContactTriggerHelper {
 /*
 * On Contact to update the Account Name field with contact Last Name, concatenated in the end.
 *  Example: If you Create A Contact whose FirstName='Sarthak' and LastName='Saxena'
 *  and the Accountname ='Tata', Then Account name must become 'TataSaxena'.
 */ 
    public static void updateAccountName(MAP<ID,CONTACT> contactMap){
        //THIS IS BEST PRACTICE JUST 2 LINES OF CODE TO DO LOOK BELOW
        Set<ID> contId=contactMap.keySet();
        MAP<ID,ACCOUNT> accountMap1=new MAP<ID,ACCOUNT>([SELECT ID,NAME FROM ACCOUNT WHERE ID IN (SELECT AccountId from Contact where id in: contId)]);
		System.debug('AccountMap1 in contact trigger helper>>>>>>>>>>>>> '+accountMap1);
        
        
        //THIS IS GOOD BUT NOT MUCH EFFICIENT CODE SAME CAN BE DONE BY THE ABOVE 2 LINES OF CODE.
        Set<ID> accountID=new Set<ID>();
        Try{
            for(ID contactid: contactMap.keySet()){
            if(contactMap.get(contactid).AccountId !=NULL){
                accountID.add(contactMap.get(contactid).AccountId);
            }
        }
        System.debug('AccountID>>>>>>>>>>>>>>>> '+accountID);
            
        }
        Catch(Exception e){
            System.debug('Exception in update Account name '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        Try{
            

            MAP<ID,ACCOUNT> accountMap=new MAP<ID,ACCOUNT>([SELECT ID,NAME FROM ACCOUNT WHERE ID IN :accountID]);
            System.debug('AccountMap in contact trigger helper>>>>>>>>>>>>> '+accountMap);
            System.debug(accountMap.values());
          
            
            for(ID account:accountMap.keySet()){
            for(ID contactID:contactMap.keySet()){
            if(contactMap.get(contactid).AccountId==account){
                accountMap.get(account).Name= accountMap.get(account).Name+ ' '+contactMap.get(contactid).lastName;

            }
        }
        }
            update accountMap.values();
            //update contactMap.values();
           
        }
        catch(Exception e){
            System.debug('Exception in contact in contactTriggerHelper>>>> '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
    }
    
 /*
  * 
  * Update the above trigger5 to delete the Last Name from the Account field when a
  * Contact is deleted without deleteing the other Last name.   
  */ 
    
    public static void deleteLastName(Map<ID,CONTACT> contactMap){
        Set<ID> accountID=new Set<ID>();
        Try{
            for(ID contactid: contactMap.keySet()){
            if(contactMap.get(contactid).AccountId !=NULL){
                accountID.add(contactMap.get(contactid).AccountId);
            }
        }
        System.debug('AccountID in delete name>>>>>>>>>>>>>>>> '+accountID);
            
        }
        Catch(Exception e){
            System.debug('Exception in update Account name '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        Try{
            MAP<ID,ACCOUNT> accountMap=new MAP<ID,ACCOUNT>([SELECT ID,NAME FROM ACCOUNT WHERE ID IN :accountID]);
            System.debug('AccountMap in contact trigger helper>>>>>>>>>>>>> '+accountMap);
            System.debug(accountMap.values());
          for(ID account:accountMap.keySet()){
            for(ID contactID:contactMap.keySet()){
            if(contactMap.get(contactid).AccountId==account){
                
                accountMap.get(account).Name= accountMap.get(account).Name.replaceFirst(contactMap.get(contactid).lastName,'');

            }
        }
        }
            update accountMap.values();
           
        }
        catch(Exception e){
            System.debug('Exception in contact in contactTriggerHelper>>>> '+e.getLineNumber());
            System.debug(e.getMessage());
        }

        
        
    }
    
//Write a trigger to populate the account picklist status to closed if there are
// atleast three related contact exist with status ""Closed"    
    
    public static void changeStatus2(Map<Id,Contact> contactMap)
    {
        Set<ID> contactId=contactMap.keySet();
        Map<ID,Account> accountMap=new Map<ID,Account>([select id,Status2__c,(select id,Status2__c from contacts where Status2__c='Close')from Account
                               where id in(select AccountID from Contact where id in:contactID ) limit 241]);
        
        System.debug('Account Map '+accountMap);
        
        for(Account account:accountMap.values()){
            if(account.contacts.size()>=3){
                account.status2__c='close';
            }
           
        }
        update accountMap.values();
        
    }
}