({
	doInit : function(component, event, helper) {
        var action=component.get("c.getObjects");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(component.isValid() && state==='SUCCESS'){
                console.log("successfull call back ");
                var objectNameList=response.getReturnValue();
                console.log(objectNameList);
                component.set("v.sobjectName",objectNameList);
            }
            else {
                console.log('state error kindly do check for errors ');
            }
        });
        $A.enqueueAction(action);
	},
    getFields :  function(component, event, helper) {
        var objectNames=component.find("mySelect1").get("v.value");
                var action=component.get("c.getFieldNames");
        action.setParams({
            "objectName" : objectNames
        });
        
        action.setCallback(this,function(response){
          var state=response.getState();
            if(component.isValid() && state==='SUCCESS'){
                var objectFieldList=response.getReturnValue();
                console.log(objectFieldList);
                component.set("v.fieldList",objectFieldList);
            }
            else {
                console.log('state error kindly do check for errors ');
            }
        });
        $A.enqueueAction(action);

        
    }
})