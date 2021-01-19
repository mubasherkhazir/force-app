public class StudentDataApexController {

    @AuraEnabled
    public static List<Associate_students__c> getStudent(){
        return [SELECT Id, Name, CreatedDate, CreatedById, Status__c FROM Associate_students__c limit 20];
    }
    @AuraEnabled
    public static void deleteStudent(Id stud){
        
        delete [select id from Associate_students__c where id=:stud];
    }
}