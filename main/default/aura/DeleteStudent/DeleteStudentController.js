({
    handleDelete : function(component, event, helper) {
        var rowId=component.get("v.strRecordId");
        var action=component.get("c.deleteStudent");
        action.setParams({
            "stud": rowId 
        });
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                component.find('notifLib').showToast({
                    "variant": "success",
                    "title": "Confirm",
                    "message": "Record Deleted Successfully!!"
                });
            }
        });
        $A.enqueueAction(action);
        component.find("overlayLib").notifyClose();
        $A.get('e.force:refreshView').fire();
        
        
        
    },
    handleCancel : function(component, event, helper) {
        //closes the modal or popover from the component
        component.find("overlayLib").notifyClose();
    }
})