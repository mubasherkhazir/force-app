({
    handleClick: function(component, event, helper) {
        var btnClicked = event.getSource();         // the button
        
        var btnMessage = btnClicked.get("v.label"); // the button's label
                alert(btnMessage);

        component.set("v.message", btnMessage);// update our message
        
    }
})