public with sharing class StudentController {

    @AuraEnabled
    public static Student__c insertStudent(Student__c student){
        
        insert student;
        return student;
    }
    
    @AuraEnabled
    public static Student__c getStudent(ID StudentID){
        
        List<Student__c> studentList=[select id,Name,LastName__c,firstName__c,Age__c from 
                                     Student__c where ID=:StudentID];
        
        if(!studentList.isEmpty())
        {
        return studentList[0];    
        }
        
        return null;
        
    }
    
    @AuraEnabled
    
    public static ID getStudentID(){
        list<Student__c> studentList=[select id from Student__c ];
        
        if(!studentList.isEmpty()){
            return studentList[0].id;
        }
        return null;
        
    }
    
}