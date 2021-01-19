/*
     * 2-Create the object called “Books” and create field “Price”(data type is Currency) under this object.
     * Whenever we enter some amount of money in the Price field and once we click on save button,
     * the value we entered in the Price field is 10% less than the actual price.
     * This is applicable for while both inserting and updating records.
     */ 
    public class BooksTriggerHelper {
        public static Boolean flag=true;
        public static void priceDiscount(Map<ID,Books__C> booksMap){
                            System.debug('book Map  '+booksMap);

            try{
                
                 set<ID> idSet=booksMap.keySet();
            Map<ID,Books__c> bookMap=new Map<ID,Books__c>([select id,Price__c from Books__C where ID in:idSet limit 2000]);
                System.debug('book Map set data '+bookMap);
            
            List<Books__c> booksList=new List<Books__c>();
            
            for(Books__c book:bookMap.values())
            {
                
                System.debug('Starting price '+book.Price__c);
                book.Price__c = book.Price__c -((book.Price__c*10)/100);
                System.debug('DIscounted price price '+book.Price__c);
                booksList.add(book);
                
            }
            
            if(!booksList.isEmpty())
            upsert booksList;
            
            }
            Catch(Exception e){
                
                System.debug('Exception caught in Books >> '+e.getMessage());
                System.debug(e.getMessage());
            }
           
            
            
        }
        
    
    }