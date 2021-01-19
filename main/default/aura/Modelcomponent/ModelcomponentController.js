({
    doInit: function(component) {
        var strAccId = component.get("v.recordId");
        console.log('Account Id ====>'+strAccId);
        $A.createComponent("c:UpdateOpportunity",{strRecordId : strAccId},
                           function(result, status) {
                               if (status === "SUCCESS") {
                                   component.find('overlayLibDemo').showCustomModal({
                                       header: "Opportunity Edit Form",
                                       body: result, 
                                       showCloseButton: true,
                                       cssClass: "mymodal", 
                                   })
                               }                               
                           });
    }
})