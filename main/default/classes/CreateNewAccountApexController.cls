public class CreateNewAccountApexController {
    
    @AuraEnabled
    public static void createAccountApex(List<Account> accList){
        System.debug(accList);
        if(!accList.isEmpty()){
            insert accList;
        }
    }

}