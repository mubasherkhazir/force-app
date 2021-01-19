({
    setNavigation : function(component, event, helper) {
        var cmpEvent = component.getEvent("cmpEvent");
        var index = component.get("v.index");
        
        cmpEvent.setParams({"navIndexEvent" : index});
        cmpEvent.fire();
    },
})