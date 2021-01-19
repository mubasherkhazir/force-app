({
    doInit : function(component, event, helper){
        var recordID=null; //component.get("v.recordId");
        
        if(recordID==null){
            var action=component.get("c.getStudentID");
                action.setCallback(this,function(response){
                recordID=response.getReturnValue();
                component.set("v.idRecord", recordID);

                alert(recordID);
            });
            $A.enqueueAction(action);
        }
        
        //alert(recordID);
        
    },
    
    submit : function(component, event, helper) {
        alert("button clicked");
        var student=component.get("v.student");
        var action=component.get("c.insertStudent");
        console.log(student.Name);
        action.setParams({
            "student" :student
        });
        
        action.setCallback(this,function(response){
            
            var state=response.getState();
            if(state=='SUCCESS'){
                alert("inserted ");
                var studentDetails=response.getReturnValue();
                console.log(studentDetails);
                
            }
            
            else{
                alert("false not");
                console.log(state);
            }
            
        });
        $A.enqueueAction(action);
        
    },
    save : function(component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
        alert("updated ");
        
    },
    
})