/*
* Find atleast 5 Account from your ORG having highest number of Contacts and It should be displayed
*  in ascending order.Suppose two Accounts having the same number of Contacts then it should display
*  only one Account among them(Accounts having same no. of Contacts).
*/ 

public class FindAccounts {
    public static void findAccount(){
        
        list<Account> accountList=[select id,name from Account limit 500];
        System.debug('all account list '+accountList);
        list<Contact> contactList=[select id,LastName,AccountID from Contact where AccountID IN :accountList];
        
        System.debug('Contact list associated with accounts '+contactList);
        
        Map<Integer,Account> accountMap=new Map<Integer,Account>(); 
        
        //COUNT THE CONTACTS AND ADD THEM TO A MAP, MAKING CONTACT COUNT THEIR ID,
        //IF SAME NO OF CONTACTS ARE ENCOUNTERED THEN IT WILL REPLACE IT, THUS DISPLAYING ONLY ONE OF THEM.
        
        for(Account account:accountList){
            Integer count=0;
            for(Contact contact:contactList){
                if(contact.AccountId==account.Id){
                    Count++;
                }
                
            }
            accountMap.put(count,Account);
            System.debug(count + ' '+Account.Name);
        }
        
        System.debug(accountMap.values());
        
        List<Integer> aList = new List<Integer>();
        aList.addAll(accountMap.keySet());
        aList.sort();
        //so here you will get sorted total base on key
        Integer counter=0;
        for(Integer a: aList)
        {	
            if(counter==5)
                break;
            
            System.debug( '::::::::::::: ' + accountMap.get(a)) ;
            
            counter++;
        }
        
        
        
    }
    public static void findAccount1()
    {
        //UPDATED CODE WITH SAME FUNCTIONALITY AS ABOVE 
        Map<ID,Account> accountMap1=new Map<ID,Account>([select id,Name,(select id,Name from contacts) from Account limit 500]);
        
        Map<Integer,Account> accountMap=new Map<Integer,Account>(); 
        
        for(Account account:accountMap1.values())
        {
            
            accountMap.put(account.contacts.size(),Account);
            System.debug(account.contacts.size() + ' '+account.Name);
            
            
        }
        System.debug(accountMap.values());
        
        List<Integer> aList = new List<Integer>();
        aList.addAll(accountMap.keySet());
        aList.sort();
        //so here you will get sorted total base on key
        
        List<Integer> finalList = new List<Integer>();
        integer siz=aList.size()-5;
        for(Integer i = aList.size()-1; i>=0;i--)
        {
            
            finalList.add(aList.get(i));
            if(i==siz)break;
            
        }
        
        System.debug('Check the Order -->'+finalList);
        
        finalList.sort();
        System.debug('Ascending order final List >> '+finalList);
        
        for(Integer a:finalList){
            
            System.debug('No of Contacts ::'+a+', Account Name ::'+accountMap.get(a));
        }
        
        
        
        
    }
    
    
}