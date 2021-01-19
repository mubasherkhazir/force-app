@isTest
public class BooksTriggerHelper_TestClass {

    @isTest
    public static void discountTest(){
        Books__C book=new Books__C();
        book.Name='Harry Potter';
        book.Price__c=100;
        insert book;
    }
     @isTest
    public static void negativeTest(){
        Books__C book=new Books__C();
        book.Name='Harry Potter';
        insert book;
    }
}