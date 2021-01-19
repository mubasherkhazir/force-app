public class GetSobject {
    @AuraEnabled
    public static List <EntityDefinition> getObjects(){
        List <EntityDefinition> ObjectName=[SELECT  QualifiedApiName FROM EntityDefinition order by QualifiedApiName];
        return ObjectName;
    }
    
    @AuraEnabled
    public static List<FieldDefinition> getFieldNames(String objectName){
        List<FieldDefinition> fieldName=[SELECT  Label, DataType,QualifiedApiName FROM FieldDefinition WHERE
                                         EntityDefinition.QualifiedApiName =:objectName limit 200];
        return fieldName;
        
        
    }
}