public class ContentVersionExample {
    
    public ContentVersionExample(){
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Inserting Again 2';
        cv.PathOnClient = 'PublishTest.pdf';
        cv.VersionData = Blob.valueOf('Publish to Hello');
        cv.IsMajorVersion = true;
        cv.FirstPublishLocationId=[select id from contentWorkspace where Name='Hello' limit 1].Id;
        Insert cv;
    }
    
}