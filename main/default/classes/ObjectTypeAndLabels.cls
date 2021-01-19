//Create a script to print all fields labels, API name, and data type of the given object.

public class ObjectTypeAndLabels {
    public static void getLabels(String name){
        
        Map<String,Schema.SObjectType> SchemaMap=Schema.getGlobalDescribe() ;       
        Schema.SObjectType schemaLabel=SchemaMap.get(Name);
        Map<String, Schema.SObjectField> ApiName = schemaLabel.getDescribe().fields.getMap();

        
        for (String fieldName: ApiName.keySet()) {
            
            System.debug('##Field API Name= '+fieldName);
            System.debug('##Field Label= '+ApiName.get(fieldName).getDescribe().getLabel());
            System.debug('##Field Data Type= '+ApiName.get(fieldName).getDescribe().getType());
            
        }
        
    }
    
}