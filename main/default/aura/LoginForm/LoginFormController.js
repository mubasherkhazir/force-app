({
    userLogin : function(component, event, helper) {
        
        var userName = component.get("v.Username");
        var password = component.get("v.Password");
        var action = component.get("c.getDetails");
        
        action.setParams({
            "username" : userName,
            "password" : password
        });
        action.setCallback(this, function(a){
            var flag=false;
            if(a.getReturnValue()===false){
                alert("Invalid Username/Password");
            }
            else{
                flag=true;
                alert("Welcome! User Logged In");
            }
            var evt = $A.get("e.c:Result");
            
            
            evt.setParams({ "flag":flag});
            evt.fire();
            
            console.log(JSON.stringify(a.getReturnValue()));
            var str = JSON.stringify(a.getReturnValue());
            
        });
        $A.enqueueAction(action);
        component.set("v.Username",'');
        component.set("v.Password",'');
    },
    
    handleForget : function(component, event, helper) {
        var evt = $A.get("e.force:navigateToComponent");
    evt.setParams({
        componentDef : "c:forgetPassword"
    });
    evt.fire();
        
    }
})