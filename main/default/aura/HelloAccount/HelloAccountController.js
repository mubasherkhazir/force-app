({
    

    handleClick: function(component, event, helper){
        console.log('Button successs');
        var inputData= component.get("v.accoutName2");
        var action=component.get("c.createAccountApex");
        var list2=component.get("v.accountList");
        list2.push(inputData);
      
        action.setParams({
            'accList':list2
        });
        
        action.setCallback(this, function(data){
            console.log('My ::::loop');
            var state= data.getState();
            console.log(state);
            if(state=== 'SUCCESS')
            {
                var valueByApex= data.getReturnValue();
                console.log('Into the loop');
                console.log(valueByApex);
                // component.set("v.accoutName",dm);
                
            }
            else if(state=="ERROR")
            {
                
                
                console.log('Eror the loop'+data.getError());
            }
        });
        
        $A.enqueueAction(action);
    }
})