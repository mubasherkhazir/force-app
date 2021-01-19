({
    sObjPickList: function(component, event, helper) {
        var action = component.get("c.getsObjOptions");
        
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var value = response.getReturnValue();
                component.set("v.sObject", value);
            }
            else{
                console.log('error'+response.message);
            }
        });
        $A.enqueueAction(action);
    },
    sObjFields:function (component,event,helper) {
        try{
            var action = component.get("c.getFieldOfSobj");
            action.setParams({
                "strs":component.find("auraId").get("v.value")
            });
            action.setCallback(this ,function (returnResponse) {
                if(returnResponse.getState() == "SUCCESS"){
                    var returnValue = returnResponse.getReturnValue();
                    component.set("v.objField",returnValue);
                }
                else{
                    console.log('error'+returnResponse.message);
                }
            });
            $A.enqueueAction(action);
            
        }
        catch(ex){
            console.log('ex.message------->'+ex.message);
        }
    },
})