({
    COLUMNS: [
        { label: 'Account Name', fieldName: 'Name' ,
         sortable: true },
        {
            label: 'Industry',
            fieldName: 'Industry',
            type: 'text',
            sortable: true,
            cellAttributes: { alignment: 'left' },
        },
        { label: 'Email', fieldName: 'email', type: 'email' ,
         sortable: true},
    ],
        
        setColumns: function(component) {
        
        component.set('v.columns', this.COLUMNS);
        },
        
        setData: function(component) {
        var action=component.get("c.getAccount");
        action.setCallback(this,function(response){
        
        if(response.getState()==='SUCCESS'){
        var data=response.getReturnValue();
        component.set('v.data',data);
        }
        
        });
        $A.enqueueAction(action);
        },
        
        // Used to sort the 'Age' column
        sortBy: function(field, reverse, primer) {
        var key = primer
        ? function(x) {
        return primer(x[field]);
}
 : function(x) {
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
    }
})