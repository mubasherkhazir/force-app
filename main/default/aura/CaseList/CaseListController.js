({
	goToRecord : function (component, event, helper) {
    var sObjectEvent = $A.get("e.force:navigateToSObject");
    sObjectEvent.setParams({
      "recordId": "v.case.Id",
      "slideDevName": "detail"
    });
    navEvt.fire();
}
})