({
	doInit : function(component, event, helper) {
		var action=component.get("c.getCasesDB");
        console.log("inside do init");
        action.setCallback(this,function(response){
                           var state=response.getState();
            if(component.isValid() && state==="SUCCESS"){
                console.log("getting cases");
                component.set("v.cases",response.getReturnValue());
            }
                           });
        $A.enqueueAction(action);
	},
    
})