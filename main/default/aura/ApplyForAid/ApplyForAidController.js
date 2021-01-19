({
    
    doInit : function(component, event, helper) {
        var recordID=null;
         var action=component.get("c.getStudentID");
             action.setCallback(this,function(response){
                 recordID=response.getReturnValue();
                component.set("v.idRecord", recordID);
                alert("record id get "+recordID);
            });
           $A.enqueueAction(action);

    },
    
    applyForAid : function(component, event ,helper){
        //Create the action
        alert("clicked");
        var recordID=component.get("v.idRecord");
        var action=component.get("c.applyForAidAction");
        //helper.loadRecord(component, recordID);         
        action.setParams({"studentID": recordID});
        alert("in set params");
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log(state);
            if(component.isValid() && state==='SUCCESS'){
                console.log("inside valid condition");
                helper.loadRecord(component,recordID);  
                $A.get('e.force:refreshView').fire();
            }
            
            else
                alert("failed with state")            
                });
        
        //send action off to be executed 
        
        $A.enqueueAction(action);
        
    }
})