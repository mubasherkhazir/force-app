({
    getData: function(component, event, helper)
    {
        var ShowResultValue = event.getParam("flag");
        // set the handler attributes based on event data
        component.set("v.flag", ShowResultValue);
        if(ShowResultValue===true){
        var welcome=component.find("welcome");
        $A.util.toggleClass(welcome,'slds-show');
        }
        
    },
    doInit: function(component, event, helper)
    {
      var welcome=component.find("welcome");
        $A.util.toggleClass(welcome,"slds-hide");
    },
    handleLogin : function(component, event, helper)
    {
        var x=component.get("v.increment");
        x=0;
        component.set("v.increment",x);
        
    },
    handleSignup : function(component, event, helper)
    {
        var x=component.get("v.increment");
        x=1;
        component.set("v.increment",x);
        
    }
})