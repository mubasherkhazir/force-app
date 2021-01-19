({
    loadRecord : function(component, recordID) {
        
        var action=component.get("c.getStudent");
        alert("new student id "+recordID);
        action.setParams({"studentID":recordID});
        
        
        //add a call back behavor 
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log("State " +state);
            if(state=='SUCCESS'){
                console.log('inside success');
                var studentR=response.getReturnVale();
                console.log("studentR = " +studentR);
                component.set("v.student",studentR);
            }
            else
                console.log("Failed with state "+state);
        });
        //send action off to be executed 
        
        $A.enqueueAction(action);
        
    }
})