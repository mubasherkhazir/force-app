({
	doInit : function(component, event, helper) {
  var action=component.get("c.getExpense");
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS' && component.isValid()){
                console.log("success");
                component.set("v.expense",response.getReturnValue());
                console.log();
            }
            else{
                console.log("error");
            }
        });
        $A.enqueueAction(action);
	},
    
    doInit : function(component, event, helper) {
        var mydate = component.get("v.expense.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
    },

    clickReimbursed: function(component, event, helper) {
        var expense = component.get("v.expense");
        var updateEvent = component.getEvent("updateExpense");
        updateEvent.setParams({ "expense": expense });
        updateEvent.fire();
    }

    
})