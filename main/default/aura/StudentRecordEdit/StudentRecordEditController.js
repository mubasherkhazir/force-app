({
    handleCancel : function(component, event, helper) {
        //closes the modal or popover from the component
        component.find("overlayLib").notifyClose();
    },
    handleSubmit : function(component, event, helper) {
        component.find('editform').submit();
        $A.get('e.force:refreshView').fire();
        
    },
    handleUpdate : function(component, event, helper) {
        component.find('editform').submit();
        component.find("overlayLib").notifyClose();
        
    },
    
    handleSuccess : function(component, event, helper) {
        var  studNamestr= component.find("studName").get("v.value");
        component.find('notifLib').showToast({
            "variant": "success",
            "title": studNamestr,
            "message": "Record Updated Successfully!!"
        });
        component.find("overlayLib").notifyClose();
        $A.get('e.force:refreshView').fire();
        
    },
})