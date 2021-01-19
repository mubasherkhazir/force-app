({
    doInit : function(component, event, helper) {
        var canditate=component.get("v.newAccount");
        var action=component.get("c.saveAccount");
        console.log(action);
        action.setParams({ "acc":canditate                                   
                         });
        
        action.setCallback(this,function(a){
            var state=a.getState();
            console.log(state);
            if(state=="SUCCESS"){
                var accdetails=a.getReturnValue();
                component.set("v.newAccount",accdetails);
                alert('Record Insert');
            }else if(state=="Error"){
                alert('Error');
            }
            
        });
        $A.enqueueAction(action);
    }
})