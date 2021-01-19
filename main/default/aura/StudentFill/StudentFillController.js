({
    submit : function(component, event, helper) {
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

}
 })