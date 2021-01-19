({
	 addItem : function(component, event, helper) {
        
        $A.createComponent("c:OpportunityForm",
                           {
                               "enable" :false,
                           },
                           function(newCard, status, errorMessage){
                               if (status === "SUCCESS") {
                                   var body = component.get("v.body");
                                   body.push(newCard);
                                   component.set("v.body", body);
                               }
                               else if (status === "INCOMPLETE") {
                                   console.log("No response from server or client is offline.")
                               }
                                   else if (status === "ERROR") {
                                       console.log("Error: " + errorMessage);
                                   }
                           }
                          );        
        
    },
    
    destroy : function(component, event, helper) {
        component.destroy();
    }
})