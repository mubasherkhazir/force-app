//Update the field Last Acquistion Date of contact with 
//Last Sale Date of property if the last sale price is not null.
//Last_Sale_Date__c Last_Sale_Price__c Contact__c Last_Acquistion_Date__c

public class UpdateContactAcquisition {
    
    public static void updateContact(Map<id,Property__c> propertyMap){
        Set<ID> propertyId=propertyMap.keySet();
        System.debug('Property id '+propertyId);
        Map<ID,Contact> contactMap=new Map<ID,Contact>([select id,Last_Acquistion_Date__c from Contact where id in(
            select Contact__c from Property__c where id in:propertyID) limit 412]);
        System.debug('ContactMap >>>> '+contactMap);
        try{
            
            List<Contact> contactList=new List<Contact>();
            for(Property__c property: propertyMap.values()){
                System.debug('Property '+property);
                System.debug('Contact ID '+property.Contact__c);
                Contact contact=contactMap.get(property.Contact__c);
                System.debug('Contact recieved '+contact);
                if(property.Last_Sale_Price__c !=NULL){
                    System.debug('Last sale price '+property.Last_Sale_Price__c);
                    contact.Last_Acquistion_Date__c=property.Last_Sale_Date__c;
                    System.debug(' last acquisiton '+contact.Last_Acquistion_Date__c);
                    contactList.add(contact);
                }
                
            }
            update contactMap.values();
            System.debug('Contact updated ');
            
            //if(!contactList.isEmpty())
               // insert contactList;
        }
        Catch(Exception e){
            System.debug('Exception caught '+e.getLineNumber());
            System.debug(e.getMessage());
        }
        
        
        
        
        
    }
    
    
    
}