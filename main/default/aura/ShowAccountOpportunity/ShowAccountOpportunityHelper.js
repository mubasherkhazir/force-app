({ 
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Account Name', fieldName: 'v.Name', type: 'text'},
            {label: 'Opportunity', fieldName: 'v.mySelect1', type: 'text'},
            {label: 'Contacts', fieldName: 'v.mySelect2', type: 'text'},
        ]);
        var action = component.get("c.getAccount");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
})