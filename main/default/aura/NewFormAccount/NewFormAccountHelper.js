({
	toggleOneAndTwoSteps : function(component) {
		var stepOne = component.find("stepOne");
        $A.util.toggleClass(stepOne, 'slds-hide');
        var stepTwo = component.find("stepTwo");
        $A.util.toggleClass(stepTwo, 'slds-hide');
	},
    toggleTwoAndThreeSteps : function(component){
        var stepTwo = component.find("stepTwo");
        $A.util.toggleClass(stepTwo, 'slds-hide');
        var stepThree = component.find("stepThree");
        $A.util.toggleClass(stepThree, 'slds-hide');
    },
    toggleFirstPage : function(component){
        var stepOne = component.find("stepOne");
        $A.util.toggleClass(stepOne, 'slds-hide');
        var stepThree = component.find("stepThree");
        $A.util.toggleClass(stepThree, 'slds-hide');
        
    },
    resetFields : function(component,event,helper){
        var nameCmp=component.find('NameField');
        var name=nameCmp.set("v.value",'');
        console.log(name);
        var username=component.find('UserName').set("v.value",'');
        console.log(username);
        var password=component.find('Password').set("v.value",'');
        console.log(password);
        var gender=component.find('Gender').set("v.value",'');
        console.log(gender);
        var dob=component.find('DOB').set("v.value",'');
        console.log(dob);
        var Address1=component.find('Address1').set("v.value",'');
        console.log(Address1);
        var Address2=component.find('Address2').set("v.value",'');
        console.log(Address2);
        var ZipCode=component.find('ZipCode').set("v.value",'');
        console.log(ZipCode);
        var Country=component.find('Country').set("v.value",'');
        console.log(Country);
        var Country=component.find('Contactfield').set("v.value",'');
        console.log(Country);
        var Country=component.find('QuestionsField').set("v.value",'');
        console.log(Country);
        var Country=component.find('AnswerField').set("v.value",'');
        console.log(Country);
        var Country=component.find('Phonefield').set("v.value",'');
        console.log(Country);
        component.set("v.flag",false);
        
    },
 linkImage : function(component,event,helper){
    var id=component.get("v.contentId");
     console.log("id ======== "+id);
    var action=component.get("c.attachImage");
    action.setParams({
        "contentId" : id
    });
     action.setCallback(this,function(response){
         if(response.getState()==='SUCCESS'){
             alert("success");
         }
         else{
             alert("error occured");
         }
         
     });
    $A.enqueueAction(action);
    
}
        
})