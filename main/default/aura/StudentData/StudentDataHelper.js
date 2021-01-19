({
    
    
    setColumns: function(component) {
        var actions = [
            { label: 'Edit', name: 'Edit' },
            { label: 'Delete', name: 'delete' }
        ];
        component.set('v.columns', [
            
            { label: 'Name', fieldName: 'Name' ,sortable: true },
            { label: 'Created by',fieldName: 'CreatedById', type: 'text',sortable: true,cellAttributes: { alignment: 'left' }},
            { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' ,sortable: true},
            { label: 'Status', fieldName: 'Status__c', type: 'picklist' ,sortable: true},
            { type: 'action', typeAttributes: { rowActions: actions } },
        ]);
            },
            
            setData: function(component) {
            var action=component.get("c.getStudent");
            action.setCallback(this,function(response){
            
            if(response.getState()==='SUCCESS'){
            var data=response.getReturnValue();
            component.set('v.data',data);
            }
            
            });
            $A.enqueueAction(action);
            },
            
            // Used to sort the column
            sortBy: function(field, reverse, primer) {
            var key = primer ? 
            function(x) {
            return primer(x[field]);
    }: 
    function(x) {
    return x[field];
};
 
 return function(a, b) {
    a = key(a)?key(a):'';
    b = key(b)?key(b):'';
    return reverse * ((a > b) - (b > a));
};
},
    
    handleSort: function(cmp, event) {
        var sortedBy = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        var data=cmp.get("v.data");
        var cloneData = data.slice(0);
        cloneData.sort((this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1)));
        
        cmp.set('v.data', cloneData);
        cmp.set('v.sortDirection', sortDirection);
        cmp.set('v.sortedBy', sortedBy);
    },
        removeBook: function (cmp, row) {
            var modalBody;
            var rec=row.Id;
            $A.createComponent("c:DeleteStudent",{strRecordId : rec},
                               function(content, status) {
                                   if (status === "SUCCESS") {
                                       modalBody = content;
                                       cmp.find('overlayLib').showCustomModal({
                                           header: "DELETE RECORD",
                                           body: modalBody,
                                           showCloseButton: true,
                                           cssClass: "mymodal",
                                           closeCallback: function() {
                                               console.log("successful callback");
												var toastEvent = $A.get("e.force:showToast");
                                               toastEvent.setParams({
                                                   "title": "Success!",
                                                   "message": "The record has been updated successfully."
                                               });
                                               toastEvent.fire();
                                               var rows = cmp.get('v.data');
                                               var rowIndex = rows.indexOf(row);
                                               rows.splice(rowIndex, 1);
                                               cmp.set('v.data', rows);
                                           }
                                       })
                                   }
                               });
            
            $A.get('e.force:refreshView').fire();
            
        },
            
})