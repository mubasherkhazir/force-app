@isTest
public class StudentController_TestClass {

    @isTest
    public static void testStudent(){
        Student__c stud=new Student__c();
        stud.Name='Mubashir';
        stud.FirstName__c='Khazir';
        stud.LastName__c='Lone';
        stud.Age__c=23;
        stud.GPA__c=8;
        
       Student__c student= StudentController.insertStudent(stud);
       Student__c student2=StudentController.getStudent(student.Id);
       ID studi=StudentController.getStudentID();
        
    }
    
    @isTest
        public static void nullTest(){
        Student__c stud=new Student__c();
        stud.Name='Mubashir';
        stud.FirstName__c='Khazir';
        stud.LastName__c='Lone';
        stud.Age__c=23;
        stud.GPA__c=8;    
       Student__c student2=StudentController.getStudent(stud.Id);
       ID studi=StudentController.getStudentID();

}
}