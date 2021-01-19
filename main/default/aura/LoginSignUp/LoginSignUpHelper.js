({
	Init : function(component, event, helper) {
        var flag;
        var x=component.get("v.increment");
        if(x>=1)
        {
            flag=false;
        }
        else
        {
            flag=true;
        }
        component.set("v.flag",flag);
        var flag2;
        if(x<2)
        {
            flag2=false;
        }
        else
        {
            flag2=true;
        }
        component.set("v.flag2",flag2);        
    },
})