({
    doInit : function(component, event, helper) {
        var action=component.get("c.getItems");
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS' && component.isValid()){
                console.log("success");
                component.set("v.item",response.getReturnValue());
                console.log();
            }
            else
            {
                console.log("error");
            }
        });
        $A.enqueueAction(action);
    },
    
    packItem :  function(component, event, helper) {
        
        component.set("v.item.Packed__c",true);
        component.set("v.disabled",true);
        
        
        
        
        
    }
    
})