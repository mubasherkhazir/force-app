public class GetCustomRecord{
    @AuraEnabled
    public static List <EntityDefinition> getsObjOptions() {
        List <EntityDefinition> OldsobjectList = new list <EntityDefinition>();
        List <EntityDefinition> sobjectList = new list <EntityDefinition>();
        try {
            OldsobjectList = [SELECT QualifiedApiName FROM EntityDefinition Order by QualifiedApiName];
            for(EntityDefinition e : OldsobjectList) {
               {
                    sobjectList.add(e);
                }
            }
        }
        catch(Exception e){
            system.debug('e.getLineNumber()------>'+e.getLineNumber()+'msg------>'+e.getMessage());
        }
        return sobjectList;
    }
    
    @AuraEnabled
    public static List<FieldDefinition> getFieldOfSobj(String strs){
        List<FieldDefinition> fieldDefinitionList = new List<FieldDefinition>();
        try{
            fieldDefinitionList = [SELECT Label,
                                   DataType,
                                   QualifiedApiName
                                   FROM FieldDefinition
                                   Where EntityDefinition.QualifiedApiName=:strs
                                  ];
        }
        catch(Exception e){
            system.debug('e.getLineNumber------->'+e.getLineNumber()+'msg------->'+e.getMessage());
        }
        return fieldDefinitionList;
    }
}