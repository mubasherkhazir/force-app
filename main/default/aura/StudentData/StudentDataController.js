({
    init: function(cmp, event, helper) {
        helper.setColumns(cmp);
        helper.setData(cmp);
    },
    
    handleSort: function(cmp, event, helper) {
        helper.handleSort(cmp, event);
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        
        switch (action.name) {
            case 'Edit':
                var modalBody;
                var rec=row.Id;
                $A.createComponent("c:StudentRecordEdit",{strRecordId : rec},
                                   function(content, status) {
                                       if (status === "SUCCESS") {
                                           modalBody = content;
                                           cmp.find('overlayLib').showCustomModal({
                                               header: "Application Confirmation",
                                               body: modalBody,
                                               showCloseButton: true,
                                               cssClass: "mymodal",
                                               closeCallback: function() {
                                                   console.log('hello callback');
                                                   window.location.reload(true);
                                               }
                                           })
                                       }
                                   });
                $A.get('e.force:refreshView').fire();
                break;
            case 'delete':
                helper.removeBook(cmp, row);
                $A.get('e.force:refreshView').fire();
                break;
        }
        
    }
});