({
    Init : function(component, event, helper) {
        var x=component.get("v.increment");
        console.log(x);
        helper.Init(component, event, helper);  
    },
    
    
    handlePrevious : function(component, event, helper) {
        var x=component.get("v.increment");
        var bar=component.get("v.bar");
        bar=bar-33;
        component.set("v.bar",bar);
        x=x-1;
        component.set("v.increment",x);
        helper.Init(component, event, helper);
        console.log(x);
    },
    
    handleNext : function(component, event, helper) {
        var bar=component.get("v.bar");
        bar=bar+34;
        component.set("v.bar",bar);
        var x=component.get("v.increment");
        x=x+1;
        component.set("v.increment",x);
        console.log(x);
        helper.Init(component, event, helper);
        
        
    },
    
    handleSubmit :function(component, event, helper) {
        alert("submitted");
        component.find("editform").submit();
        
    },
    handleSuccess : function(component, event, helper) {
    cmp.find('field').forEach(function(f) {
    f.reset();
});
}
})