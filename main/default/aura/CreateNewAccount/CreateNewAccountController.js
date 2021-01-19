({
    doInit:function(component, event, helper) {
        var recordID=component.get("v.recordId");
        component.set("v.idRecord", recordID);
    },
    
    
    
    createAccount: function(component, event, helper) {
        helper.createAccount(component,event,helper);
    },
    //ANOTHER WAY OF DOING THINGS
    handleCreateAccount : function(component, event, helper) {
        event.preventDefault();       // stop the form from submitting
        component.find("createAccountForm").submit();
    },
    //YET ANOTHER WAY OF DOING THINGS
    
    handleSubmit: function(component, event, helper) {
        event.preventDefault();       // stop the form from submitting
        var fields = event.getParam('fields');
        component.find('createAccountForm').submit(fields);
    },
    
    //RESET FORM
    cancelForm: function(component, event, helper) {
        helper.cancelForm(component);    
        
    },
    
    cancel : function(component, event, helper) {
        $A.get('e.force:closeQuickAction').fire(); 
        
    } ,
    save : function(component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
        
    },
    showToast : function(component, event) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
        $A.get('e.force:refreshView').fire();
    }
    
    
});