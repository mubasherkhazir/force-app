public class AnimalLocator {
    
    public static String getAnimalNameById(Integer id){
        
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        
        String name='';
        Http http=new Http();
        HttpResponse response=http.send(request);
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
           AnimalResult result = (AnimalResult) JSON.deserialize(response.getBody(), AnimalResult.class);
        name = result.animal.name;

        }
        System.debug('Received the following animals: '+name);
        return name;
    }
    

}