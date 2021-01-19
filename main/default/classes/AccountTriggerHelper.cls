public class AccountTriggerHelper {
    
    /*
* On Account to create a 'Default' (number of contacts= numbers of employee) 
* contact every time an account is created./update
* 
*/
    public static void createContacts(List<Account> accountList){
        
        System.debug('AccountList in account trigger helper>>>>>>>>>>>>>>'+accountList);
        
        //ADD NO OF CONTACTS TO YOUR ACCOUNT EQUAL TO YOUR NO OF EMPLOYEES.
        
        List<CONTACT> contactList=new List<CONTACT>();
        for(Account account:accountList){
            if(account.NumberOfEmployees>0){
                for(Integer i=0;i<account.NumberOfEmployees;i++){
                    Contact contact=new Contact();
                    contact.FirstName='Test ';
                    contact.LastName='Contact '+i;
                    contact.AccountId=account.Id;
                    contactList.add(contact);
                }
            }
        }
        System.debug('ContactList in account trigger helper>>>>>>>>>>>>>>>>>>>>>>>>>. '+contactList);
        
        if(!contactList.isEmpty())
            insert contactList;
        
    }
    
    public static void updateEmployee(Map<ID,Account> newAccountMap, Map<ID,Account> oldAccountMap,List<Account> accountList){
        
        List<CONTACT> contactList=new List<CONTACT>();
        Map<ID,CONTACT> contact2delete=new Map<ID,CONTACT>();
        try{
            //TO PREVENT THE ABNORMAL BEHAVIOR CAUSED BY THE INSERTION OF NULL VALUE ADDED THIS LINE.
            
            for(Account account:accountList){
                
                if(OldAccountMap.get(account.Id).NumberOfEmployees==null)
                {
                    Integer EmployeeNo=NewAccountMap.get(account.id).NumberOfEmployees;
                    for(integer i=0;i<EmployeeNo;i++){
                        Contact contact=new Contact();
                        contact.LastName='Default '+i;
                        contact.AccountId=account.id;
                        contactList.add(contact);
                        
                    }
                }
                //   WHEN THE NO OF EMPLOYEES IS INCREASED, INCREASED NO OF CONTACTS SHOULD BE ADDED TO THE ACCOUNT.
                
                else if(newAccountMap.get(account.Id).NumberOfEmployees > oldAccountMap.get(account.Id).NumberOfEmployees){
                    Integer employee=newAccountMap.get(account.Id).NumberOfEmployees-oldAccountMap.get(account.Id).NumberOfEmployees;
                    System.debug('if new > old employee ='+employee);
                    for(Integer i=0;i<employee;i++){
                        Contact contact=new Contact();
                        contact.FirstName='Update ';
                        contact.LastName='Contact '+i;
                        contact.AccountId=account.Id;
                        contactList.add(contact);
                        
                    }
                    
                    // WHEN NO OF EMPLOYEES IS DECREASED, SUCH NO OF CONTACTS SHOULD BE REMOVED, BY NOW WE ARE REMOVING WITHOUT USING ANY 
                    // SPECIFIC CRITERIA.
                    
                }
                else if(newAccountMap.get(account.Id).NumberOfEmployees < oldAccountMap.get(account.Id).NumberOfEmployees){
                    Integer employee=oldAccountMap.get(account.Id).NumberOfEmployees-newAccountMap.get(account.Id).NumberOfEmployees;
                    System.debug('if new < old employee ='+employee);
                    contact2delete=new Map<Id,Contact>([select id from contact where Accountid=:account.Id limit :employee]);
                    
                }
                
                //THIS CODE ALSO NORMALIZES AN ABNORMAL BEHAVIOUR, CAUSED BY NULL VALUE, AS NULL CAN'T BE COMPARED WITH A REAL VALUE.
                
                else if(newAccountMap.get(account.Id).NumberOfEmployees==NULL)
                {
                    contact2delete=new Map<Id,Contact>([select id from contact where Accountid=:account.Id limit 5000]);
                    
                } 
                
                
            }
            
            System.debug('Contact List 2 in account trigger helper >>>> '+contactlist);
            if(!contactList.isEmpty())
                insert contactList;
            
            system.debug('Contact 2 delete Map in account trigger helper '+contact2delete.values());
            if(!contact2delete.isEmpty())
                delete contact2delete.values();
            
            
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
    }
    
    
    
    /*
* "Create a custom ""Create Case"" checkbox field in Account object.
Write a Trigger on Account to create a new Case with all values filled whenever ""Create Case"" account field is marked as checked."

Create_Case__c	
*/
    public static void createCase(Map<ID,Account> newAccountMap,Map<ID,Account> oldAccountMap){
        System.debug('New Account Map '+newAccountMap);
        
        //set<ID> accId=newAccountMap.keySet();
        //Map<ID,Account> AccountMap=new Map<ID,Account>([select id,Name from Account Where Create_Case__c=true AND ID in :accId limit 1500 ]);
        //System.debug('Account map recieved in create case ');
        //System.debug(AccountMap);
        try{
            
            List<case> caseList=new List<case>();
            for(Account account:newAccountMap.values()){
                if(oldAccountMap.get(account.Id).Create_Case__c==false && account.Create_Case__c==true){
                    System.debug('Inside create case');
                    Case newcase=new Case();
                    newcase.AccountId=account.Id;
                    newcase.Status='new';
                    newcase.Origin='Phone';
                    caseList.add(newcase); 
                }
                
                
            }
            if(!caseList.isempty())
                Insert caseList;
            
        }
        Catch(Exception e){
            System.debug('Exception found in create case '+e.getLineNumber());
            System.debug(e.getMessage());
        }
    }
    
    
    //Write a Trigger to auto Create not more than 2 Contacts and Opportunities 
    //when the account is inserted and updated where status is Active.
    
    public static void autoCreateConOpp(Map<ID,Account> accountMap,Map<ID,Account> oldAccountMap){
        set<ID> accID=accountMap.keySet();
        System.debug('accountMap id '+accID);
        Map<ID,Account> accountMap2=new Map<ID,Account>([select id,Name,Status__c  from Account where status__c='Active' AND id in:accID Limit 145]);
        
        System.debug('AccountMap 2 recieved '+accountMap2);
        List<Opportunity> oppList=new list<Opportunity>();
        List<Contact> conList=new List<Contact>();
        System.debug('Old account Map '+oldAccountMap);
        if(oldAccountMap==NULL)
        {
            System.debug('inside if condition');
            for(Account account:accountMap2.values()){
                for(Integer i=0;i<2;i++){
                    Opportunity opportunity=CreateOpportunity.createOpportunity('New Opportunity', account.Id);
                    oppList.add(opportunity);
                    Contact contact=CreateContact.createContact('Contact Created', account.Id);
                    conList.add(contact);
                }
            } 
        }
        else
        {
            System.debug('Old account Map '+oldAccountMap);
            
            System.debug('Inside else condition ');
            for(Account account:accountMap2.values()){
                System.debug('new account status '+account.status__c);
                System.debug('old account status '+oldAccountMap.get(account.Id).status__c);
                if(account.status__c=='Active' && oldAccountMap.get(account.Id).status__c != 'Active'){
                    System.debug('inside condition');
                    for(Integer i=0;i<2;i++){
                        Opportunity opportunity=CreateOpportunity.createOpportunity('New Opportunity', account.Id);
                        oppList.add(opportunity);
                        Contact contact=CreateContact.createContact('Contact Created', account.Id);
                        conList.add(contact);
                    }
                    
                    
                }
                
            }
            
        }
        
        if(!oppList.isEmpty())
            insert oppList;
        if(!conList.isEmpty())
            insert conList;
        
        
        
        
        
    }
    //.Write a trigger on Account that whenever an Account is created an Order should be created related to it.
    
    public static void createOrder(Map<ID,Account> accountMap){
        
        
        list<Contract> contractList=new List<Contract>();
        Pricebook2 pb=[select id from pricebook2 where isStandard=true limit 1 ];
        for(Account account: accountMap.values()){
            Contract contract=new Contract();
            contract.AccountId=account.Id;
            contract.StartDate=System.today();
            contract.Status='Draft';
            contract.ContractTerm=10;
            contractList.add(contract);
        }
        if(!contractList.isEmpty()){
            insert contractList;
        }
        
        List<Order> orderList=new List<Order>();
        for(Contract contract: contractList)
        {
            Order  order=new Order();
            order.AccountId=contract.AccountId;
            order.effectiveDate=System.today();
            order.Pricebook2Id=pb.Id;
            order.status='Draft';
            order.ContractId=contract.Id;
            orderList.add(order);
        }
        
        if(!orderList.isEmpty()){
            insert orderList;
        }
        
    }
    //Write a Trigger to create a default Contact, Case, Opportunity and Contact Role. whenever an Account is created with 
    //Number of Employees > 100. Make sure the Contact is in contact field
    // of Case as well as related to Opportunity in Contact Role.        
    
    public static void createEveryThing(Map<ID,Account> accountMap){
        List<Contact>conList=new List<Contact>();
        List<Opportunity> oppList=new List<Opportunity>();
        List<case> caseList=new List<case>();
        try{
            for(Account account:accountMap.values())
            {
                if(account.NumberOfEmployees>100)
                {
                    Contact contact=CreateContact.createContact('Nice ',account.Id);
                    conList.add(contact);
                    Opportunity opportunity=CreateOpportunity.createOpportunity('Account Opportunity',account.Id);
                    oppList.add(opportunity);
                    Case newcase=new Case();
                    newcase.AccountId=account.Id;
                    newcase.Status='new';
                    newcase.Origin='Phone';
                    caseList.add(newcase); 
                }
            }
            
            if(!conList.isEmpty())
                insert conList;
            
            if(!oppList.isEmpty())
                insert oppList;
            
            if(!caseList.isempty())
                Insert caseList;
            
        }Catch(Exception e){
            System.debug('Exception e'+e.getLineNumber());
            System.debug(e.getLineNumber());
        }
        
        try{
            List<OpportunityContactRole> ocrList=new List<OpportunityContactRole>();
            for(Contact contact:conList){
                for(Opportunity op:oppList){
                    OpportunityContactRole OCR=new OpportunityContactRole();
                    OCR.ContactId=contact.id;
                    OCR.OpportunityId=op.Id;
                    ocrList.add(OCR);
                }
            }
            if(!ocrList.isEmpty())
                insert ocrList;
            
        }Catch(Exception e){
            System.debug('Exception e'+e.getLineNumber());
            System.debug(e.getLineNumber());
        }       
    }
    
    //   Write a Trigger to update the parent account of Opportunities with the parent
    //    account of Account object when account is deleted..In case there is no self lookup
    //of Account then the parent account of opportunities must be updated to the oldest created Account in the org
    
    public static void changeOpportunityParent(Map<ID,Account> oldAccountMap){
        
        Set<ID> accID=oldAccountMap.keySet();
        System.debug('Old AccountMap '+accID);
        Map<ID,Opportunity> opportunityMap=new Map<ID,Opportunity>([select id,Name,AccountID from Opportunity where AccountID in:accID limit 234]);
        System.debug('opportunity Map :: '+opportunityMap);
        
        Map<ID,Account> accParMap=new Map<ID,Account>([select id,ParentID,Name from Account where id in :accID limit 25]);
        
        Account oldestAccount=[select id from Account order by createdDate ASC limit 1];
        
        for(Opportunity opportunity:opportunityMap.values()){
            System.debug('Opportunity name '+opportunity.Name);
            System.debug('Account Name '+accParMap.get(opportunity.AccountId).Name);
            if(accParMap.get(opportunity.AccountId).ParentId != NULL)
            {
                System.debug('Setting parent of parent account ');
                opportunity.AccountId=accParMap.get(opportunity.AccountId).ParentId;
            }
            else
            { 
                System.debug('Parent account is null ');
                opportunity.AccountId=oldestAccount.Id;
            }
            
        }
        
        update opportunityMap.values();
        System.debug('Updated Successfully');
    }
    
    //Create a trigger on Account, which automatically creates a shareable link when a file is inserted.
    public static boolean flag2=true;
    public static void createShareableLink(Map<id,Account> newMap){
        flag2=false;
        Set<ID> accID=newMap.KeySet();
        
        
        ContentDocumentLink files2=[select ContentDocument.id,ContentDocument.Title, 
                                          ContentDocument.filetype from ContentDocumentLink where linkedentityid
                                          in :accID];
        
        System.debug(files2);
        ContentVersion cv = [select id from contentversion where ContentDocumentid =:files2.ContentDocument.id];
        ContentDistribution cd = new ContentDistribution();
        cd.Name = 'Test';
        cd.ContentVersionId = cv.id;
        cd.PreferencesAllowViewInBrowser= true;
        cd.PreferencesLinkLatestVersion=true;
        cd.PreferencesNotifyOnVisit=false;
        cd.PreferencesPasswordRequired=false;
        cd.PreferencesAllowOriginalDownload= true;
        upsert cd;
        
        ContentDistribution cdnew=[SELECT Id, Name, DistributionPublicUrl 
                                 FROM ContentDistribution where ContentDocumentId=:files2.ContentDocument.id limit 1];
        Account a=[select Name,Description from Account where id in :accID limit 1];
        System.debug(cdnew.DistributionPublicUrl);
        a.Description=cdnew.DistributionPublicUrl;
        //update a;
        
        
    }
    
    
    
    
    
}