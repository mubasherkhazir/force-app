public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer no,String LastName){
        
        List<Contact> conList=new List<Contact>();
        for(Integer i=0;i<no;i++){
            Contact con=new Contact();
            con.LastName=LastName;
            con.FirstName='Test '+i;
            conList.add(con);
            }
        
        return conList;
        
        
    }

}