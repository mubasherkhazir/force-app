@isTest
public class StudentAidController_TestClass {
@isTest
    public static void test(){
        
        Student__c stud=new Student__c();
        stud.Age__c=32;
        stud.Name='Mubashir';
        insert stud;
        
        
        StudentAidController.getStudent(stud.Id);
        StudentAidController.applyForAidAction(stud.Id);
        StudentAidController.getStudentID();
    }
    @isTest
    public static void test2(){
        
        Student__c stud=new Student__c();
        stud.Age__c=32;
        stud.Name='Mubashir';
        
        
        StudentAidController.getStudent(stud.Id);
        StudentAidController.applyForAidAction(stud.Id);
        StudentAidController.getStudentID();
    }
}