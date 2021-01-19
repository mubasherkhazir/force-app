({
    cancelForm : function(component) {
        component.find('field').forEach(function(f) {
            f.reset();
        });   
    },
    
    createAccount: function(component, event, helper) {
        var accList=[];
        var account =component.get("v.account");
        accList.push(account);
        console.log(JSON.stringify(accList));
        var action = component.get("c.createAccountApex");
        event.preventDefault();       // stop the form from submitting
        
        action.setParams({
            'accList' : accList
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            console.log(state);
            if (state === 'SUCCESS') {
                alert("AccountList inserted successfully");
                helper.cancelForm(component);    
            } 
            else {
                console.log(state);
                alert("AccountList not inserted ");
            }
        });
        $A.enqueueAction(action);
        
    }
    
})