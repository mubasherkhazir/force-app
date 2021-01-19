@isTest
public class TestClassProductTriggerHelper {
    
    @isTest
    public static void createTestPricebook(){
        //ID pricebook=Test.getStandardPricebookId();
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
            
        );
        update standardPricebook;
        
        Product2 prod=new Product2();
        prod.Name='Choclate';
        insert prod;
        
    }
    
    }