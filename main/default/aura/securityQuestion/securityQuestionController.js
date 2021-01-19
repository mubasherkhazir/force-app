({
    match : function(component, event, helper) {
        //Security Question part
        var flag=true;
        
        var answer=component.find('answer').get("v.value");
        console.log(answer);
        if(answer==null)
        {
            document.getElementById('errorField').innerHTML = 'Please enter your answer';
            flag=false;
        }
        else {
            document.getElementById('errorField').innerHTML = '';
            
        }           
        var action=component.get("c.matchAnswer");
        action.setParams({
            "username":username,
            "email" :email,
            "answer":answer
        });
        action.setCallback(this,function(response){
            if('SUCCESS'===response.getState()){
                console.log(response.getReturnValue());
                if(response.getReturnValue()==true){
                    flag=true;
                }
                else{
                    flag=false;
                }
            }else{
                console.log("state error or Incomplete");
            }
            
        });
        $A.enqueueAction(action);
        
    }
})