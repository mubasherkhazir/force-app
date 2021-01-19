//buildNewAccountOverrideController.js
({
    doInit : function(component, event, helper) {
        helper.toggleTwoAndThreeSteps(component);
        component.set("v.progressIndicatorFlag", "step1");
    },
    
    handleAvailability :function(component, event, helper) {
        var action=component.get("c.getUsers");
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                var userList =response.getReturnValue();
                component.set("v.users",userList);
                console.log(userList);
                var username=component.find('UserName').get("v.value");
                console.log(username);
                //var userList=component.get("v.users");
                var i;
                for(i=0;i<userList.length;i++){
                    if(username===userList[i]){
                        document.getElementById('UserNameFieldAccept').innerHTML = '';
                        document.getElementById('UserNameFieldError').innerHTML = 'UserName already Exists';
                        break;
                    }
                    else{
                        document.getElementById('UserNameFieldError').innerHTML = '';    
                        document.getElementById('UserNameFieldAccept').innerHTML = 'UserName Available';
                        
                    }
                }
            } 
            
        });
        $A.enqueueAction(action);
        
        
        
    },
    
    goToStepTwo : function(component, event, helper) {
        //getting username on every click to make it fail proof.
        
        var action=component.get("c.getUsers");
        action.setCallback(this,function(response){
            if(response.getState()==='SUCCESS'){
                var userList =response.getReturnValue();
                component.set("v.users",userList);
            } 
            
        });
        $A.enqueueAction(action);
        
        var nameCmp=component.find('NameField');
        var name=nameCmp.get("v.value");
        console.log(name);
        var username=component.find('UserName').get("v.value");
        console.log(username);
        var password=component.find('Password').get("v.value");
        console.log(password);
        var gender=component.find('Gender').get("v.value");
        console.log(gender);
        var dob=component.find('DOB').get("v.value");
        console.log(dob);
        
        var flag=true;
        
        if(name=="" ){
            document.getElementById('NameFieldError').innerHTML = 'Please enter Name!';
            flag=false;
        }
        else{
            document.getElementById('NameFieldError').innerHTML = '';  
        }
        if(username==""){
            document.getElementById('UserNameFieldError').innerHTML = 'Please enter UserName!';
            flag=false;  
        }else{
            
            // 
            var userList=component.get("v.users");
            var i;
            for(i=0;i<userList.length;i++){
                if(username===userList[i]){
                    console.log("if condition working");
                    document.getElementById('UserNameFieldAccept').innerHTML = '';
                    document.getElementById('UserNameFieldError').innerHTML = 'UserName already Exists';
                    flag=false;
                    break;
                }
                else{
                    console.log("else condition working");
                    document.getElementById('UserNameFieldError').innerHTML = ''; 
                }
            }
        }
        
        if(password==""){
            document.getElementById('PasswordFieldError').innerHTML = 'Please enter Password!';
            flag=false;  
        }else{
            document.getElementById('PasswordFieldError').innerHTML = '';
        }
        if(gender==""){
            document.getElementById('GenderFieldError').innerHTML = 'Please enter Gender!';
            flag=false;  
        }else{
            document.getElementById('GenderFieldError').innerHTML = '';
        }
        if(dob==""){
            document.getElementById('DOBFieldError').innerHTML = 'Please enter DOB!';
            flag=false;   
        }else{
            document.getElementById('DOBFieldError').innerHTML = ''
        }
        //checking for username duplicacy
        
        
        
        //CHECKING THE FINAL CONDITION       
        if(flag){
            helper.toggleOneAndTwoSteps(component);
            component.set("v.progressIndicatorFlag", "step2");
        }
        
    },
    goToStepThree : function(component, event, helper) {
        var flag=true;
        
        var Address1=component.find('Address1').get("v.value");
        console.log(Address1);
        var Address2=component.find('Address2').get("v.value");
        console.log(Address2);
        var ZipCode=component.find('ZipCode').get("v.value");
        console.log(ZipCode);
        var Country=component.find('Country').get("v.value");
        console.log(Country);
        
        var flag=true;
        
        if(Address1=="" ){
            document.getElementById('Address1FieldError').innerHTML = 'Please enter Address1!';
            flag=false;
        }
        else{
            document.getElementById('Address1FieldError').innerHTML = '';  
        }
        if(Address2=="" ){
            document.getElementById('Address2FieldError').innerHTML = 'Please enter Address2!';
            flag=false;
        }
        else{
            document.getElementById('Address2FieldError').innerHTML = '';  
        }
        if(ZipCode=="" ){
            document.getElementById('ZipCodeFieldError').innerHTML = 'Please enter ZipCode!';
            flag=false;
        }
        else{
            document.getElementById('ZipCodeFieldError').innerHTML = '';  
        }
        if(Country=="" ){
            document.getElementById('CountryFieldError').innerHTML = 'Please enter Country!';
            flag=false;
        }
        else{
            document.getElementById('CountryFieldError').innerHTML = '';  
        }
        
        
        
        if(flag){
            helper.toggleTwoAndThreeSteps(component);
            component.set("v.progressIndicatorFlag", "step3");
        }
        
    },
    goBackToStepOne : function(component, event, helper) {
        helper.toggleOneAndTwoSteps(component);
        component.set("v.progressIndicatorFlag", "step1");
    },
    goBackToStepTwo : function(component, event, helper) {
        helper.toggleTwoAndThreeSteps(component);
        component.set("v.progressIndicatorFlag", "step2");
    },
    handleSuccess : function(component, event, helper) {
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire(); 
        helper.linkImage(component,event,helper);
        helper.resetFields(component,event,helper);
        helper.toggleFirstPage(component);
        component.set("v.progressIndicatorFlag", "step1");
    },
    handleUploadFinished : function(component, event, helper) {
        var uploadedFiles = event.getParam("files");
        var documentId = uploadedFiles[0].documentId;
        console.log(documentId);
        var fileName = uploadedFiles[0].name;
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+fileName+" Uploaded successfully."
        });
        toastEvent.fire();
        
        /*$A.get('e.lightning:openFiles').fire({
            recordIds: [documentId]
        });*/
        component.set("v.contentId",documentId);
        component.set("v.flag",true);
    },
    
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    }
    
})