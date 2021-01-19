({
    doInit : function(component, event, helper) {
        var action=component.get("c.getAccounts");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(component.isValid() && state==='SUCCESS'){
                var accList=response.getReturnValue();
                component.set("v.accountList",accList);
                console.log("account list ="+JSON.stringify(accList));
            }
            else{
                console.log("some error occured kindly check for errors");
            }
            
        });
        $A.enqueueAction(action);
        
    },
    submit :function(component, event, helper){
        
        event.preventDefault();       // stop the form from submitting
        component.find("createContact").submit();
        try{
           alert("record inserted successfully")
            component.find('notifLib').showToast({
                "title": "Success!",
                "message": "The record has been Created successfully.",
                "variant":"success"
            });
        }
        catch(err){
            console.log(err);
        }
        
        
    },
})