@isTest 
private class TestDataFactoryTestClass { 
    static testmethod void test1() {
        Pricebook2 pbook=new Pricebook2();
        pbook.Id=Test.getStandardPricebookId();
        pbook.IsActive=true;
        update pbook;
        TestDataFactory.createTestRecords(5,3);
        // Run some tests
    } 
}