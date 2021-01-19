({
	doInit : function(component, event, helper) {
        alert("clicked");
        var counter=component.get("v.myAttribute");
        console.log(counter);
        counter++;
        console.log(counter);
        component.set("v.myAttribute", counter);
	},
})