({
    doInit : function(component, event, helper) {
        var action=component.get("c.getAccountList");
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS" && component.isValid()){
                
                component.set("v.accountList",response.getReturnValue());
                console.log("accounts ==> "+JSON.stringify(response.getReturnValue()));
            }
            
            else{
                alert("trouble in getting data from db");
            }
        });
        $A.enqueueAction(action);
        
    },
    sortTable : function(component, event, helper){
        var bool=component.get("v.flag");
        var action=component.get("c.getSortedList");
        action.setParams({
            "flags" : bool 
        });
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS" && component.isValid()){
                component.set("v.accountList",response.getReturnValue());
                console.log("accounts sorted==> "+JSON.stringify(response.getReturnValue()));
                $A.get('e.force:refreshView').fire();
            }
            
            else
            {
                alert("trouble in getting data from db");
            }
            component.set("v.flag",!bool);
        });
        $A.enqueueAction(action);
        
        
        
    }
})