@isTest
public class ImageCaptureClass_TestClass {
    
    @isTest
    public static void testing(){
        Quality_Site_Assessment__c qsaInstance = new Quality_Site_Assessment__c();
        qsaInstance.Name='Qsa';
        insert qsaInstance;
        
        Quality_Site_Assessment_Note__c qsa=new Quality_Site_Assessment_Note__c();
        qsa.QSA_Name__c =qsaInstance.id;
        insert qsa;
        
        ApexPages.StandardController ImageCapture = new ApexPages.StandardController(qsa);
        ImageCaptureClass captureClass=new ImageCaptureClass(ImageCapture);
                
        List<String> noteList=new List<String>();
        List<String> imageList=new List<String>();
        
        for(Integer i=0;i<5;i++){
            String hello=' '+ i;
            imageList.add(hello);
            noteList.add(hello);
        }
        String hello='';
        ImageCaptureClass.getStoreImage(imageList,noteList,hello);
        
        ImageCaptureClass.getImagesList(qsaInstance.Id);
        
            }
}