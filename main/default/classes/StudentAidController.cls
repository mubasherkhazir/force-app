public with sharing class StudentAidController {
    
    private final Student__c studentRecord;
    
    // The only time it is necessary to refer to a StandardController object is 
    // when defining an extension for a standard controller.
        public StudentAidController(ApexPages.StandardController sc)
    {
        studentRecord =(Student__c)sc.getRecord();
    }
    
    public PageReference applyForAid(){
        studentRecord.Applied_for_Financial_Aid__c	=true;
        update studentRecord;
        return null;
    }
    //we need a method to retrieve the current student 
    //
    //ADD ANOTATION TO MAKE IT ACCESSIBLE TO LIGHTENING PAGES. 
    @AuraEnabled 
    public static Student__c getStudent(ID studentID){
        if(studentID==NULL) return null;
        List<Student__c> students=[select ID,Applied_for_Financial_Aid__c from Student__c where ID=:studentID ];
        if(students.size()>0){
            return students[0];
        }
        else
        {
            return null;
        }
        
    }
    
    //WE ALSO NEED A METHOD TO APPLY FOR FINANCIAL AID
    
    @RemoteAction @AuraEnabled
    public static Boolean applyForAidAction(ID studentID){
        List<Student__c> students=[select ID,Applied_for_Financial_Aid__c from Student__c where ID=:studentID ];
        if(students.size()>0){
            students[0].Applied_for_Financial_Aid__c =true;
        		System.debug(students[0]);
            
          
        }
        update students;
        if(students.size()>0){
          return students[0].Applied_for_Financial_Aid__c;
        }
        else{
            return null;
        }
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