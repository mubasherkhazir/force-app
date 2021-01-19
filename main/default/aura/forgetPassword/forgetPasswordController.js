({
    findUser : function(component, event, helper) {
        var flag=true;
        var username=component.find('username').get("v.value");
        console.log(username);
        var email=component.find('email').get("v.value");
        console.log(email);
        var answer=component.find('answer').get("v.value");
        console.log(answer);
        
        
        if(username==null && email==null)
        {
            document.getElementById('errorField').innerHTML = 'Please enter a username OR email!';
            flag=false;
        }
        else if(answer==null)
        {
            document.getElementById('errorField').innerHTML = 'Please enter your answer';
            flag=false;
        }
            else
            {
                document.getElementById('errorField').innerHTML = '';
            }
        //Security Question part
        var action1=component.get("c.matchAnswer");
        action1.setParams({
            "username":username,
            "email" :email,
            "answer":answer
        });
        
        action1.setCallback(this,function(response){
            if('SUCCESS'===response.getState()){
                console.log(response.getReturnValue());
                if(response.getReturnValue()===true){
                    component.set("v.answerFlag",true);
                }
                else{
                    document.getElementById('errorField').innerHTML = 'Wrong Security Question Answer';
                   //component.set("v.answerFlag",false);     
                                  }
            }else{
                console.log("state error or Incomplete");
            }
        });
        $A.enqueueAction(action1);
        
        var f2=component.get("v.answerFlag");
        console.log("new flag ="+f2);
        if(flag && f2)
        {
            //username part
            var action=component.get("c.findAccount");
            action.setParams({
                "username":username,
                "email" :email
            });
            
            action.setCallback(this,function(response){
                if('SUCCESS'===response.getState()){
                    console.log(response.getReturnValue());
                    //Check if username exists
                    if(response.getReturnValue().includes("Sorry")){
                        document.getElementById('errorField').innerHTML = 'NO USER FOUND';
                    }
                    else
                    {
                        component.set("v.uname",response.getReturnValue());
                        component.set("v.flag",true);
                        var userdev=component.find("userdev");
                        $A.util.toggleClass(userdev,"slds-hide");
                    }
                }
                //THIS IS STATE failure part
                else{
                    console.log("state error or incomplete");
                }
            }); 
            $A.enqueueAction(action);
        }
    },
    
    
    
    reset : function(component, event, helper){
        var flag=true;
        //var oldPassword=component.find('oldPassword').get("v.value");
        //console.log(oldPassword);
        var newPassword=component.find('newPassword').get("v.value");
        console.log(newPassword);
        var confirmPassword=component.find('confirmPassword').get("v.value");
        console.log(confirmPassword);
        
        
        
      /*  if(oldPassword==null)
        {
            document.getElementById('oldPasswordField').innerHTML = 'Please enter Old Password';
            flag=false;
        }
        else
        {
            document.getElementById('oldPasswordField').innerHTML = '';
        } */
        if(newPassword==null)
        {
            document.getElementById('newPasswordField').innerHTML = 'Please enter New Password';
            flag=false;
        }
        else
        {
            document.getElementById('newPasswordField').innerHTML = '';
        }
        if(confirmPassword==null)
        {
            document.getElementById('confirmPasswordField').innerHTML = 'Please Confirm New Password';
            flag=false;
        }
        else
        {
            document.getElementById('confirmPasswordField').innerHTML = '';
        }
        
        //FIRST GATE CHECK
        if(flag)
        {
            //var flag=true;
            console.log("inside if function");
            if(confirmPassword==newPassword)
            {
                //flag=true;
                document.getElementById('errorField').innerHTML = '';
                
            }
            else{
                flag=false;
                document.getElementById('errorField').innerHTML = 'NEW PASSWORD AND CONFIRM NEW PASSWORD DOES NOT MATCH';
                
            }
            
            console.log("2nd gate check "+flag);
            //2nd check
            if(flag){
                var username=component.get("v.uname");
                console.log("user ="+username);
                
                var action=component.get("c.resetPassword");
                action.setParams({
                    "username": username,
                   // "oldPassword" : oldPassword,
                    "newPassword" : newPassword
                });  
                
                action.setCallback(this,function(response){
                    if('SUCCESS'===response.getState()){
                        console.log(response.getReturnValue());
                        if(response.getReturnValue()===true){
                            component.find('notifLib').showToast({
                                "title": "Success!",
                                "message": "Password changed successfully.",
                                "variant": "success"
                            });
                            var evt = $A.get("e.force:navigateToComponent");
                            evt.setParams({
                                componentDef : "c:LoginSignUpPage"
                            });
                            evt.fire();
                        }
                        else
                        {
                            document.getElementById('errorField').innerHTML = 'PLEASE ENTER CORRECT OLD PASSWORD';
                        }
                    }
                    else{
                        console.log("state error");
                    }
                    
                    
                });
                $A.enqueueAction(action);                
                
            }
            
            
        }
    }
})