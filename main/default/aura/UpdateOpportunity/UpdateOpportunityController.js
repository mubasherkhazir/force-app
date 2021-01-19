({
    handleSubmit : function(component, event, helper) {
        component.find('editform').submit();
    },

    handleSuccess : function(component, event, helper) {
        var  oppNamestr= component.find("oppName").get("v.value");
        component.find('notifLib').showToast({
            "variant": "success",
            "title": oppNamestr,
            "message": "Opportunity Updated Successfully!!"
        });
        component.find("overlayLibDemo1").notifyClose();
    },
})