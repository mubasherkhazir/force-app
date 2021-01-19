({
    doInit : function(component,event,helper){
        helper.fetchAccHelper(component,event,helper);
        console.log("inside do init");
        var action=component.get("c.getAccount");
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log(state);
            if(state==='SUCCESS'){
                var accounts=response.getReturnValue();
                component.set('v.Accounts',accounts);
                console.log("data returned successfully");
            }
            else
            {
                alert("Account capture failed");  
            }
        });
        $A.enqueueAction(action);
        
        
        
        
        
    }
})