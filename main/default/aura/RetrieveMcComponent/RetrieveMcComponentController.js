({
    myAction : function(component, event, helper) {
        
    },
    doInit : function(component, event, helper) {
        var action = component.get("c.getPiklistValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.GenreList", plValues);
            }
        });
        $A.enqueueAction(action);
        
    },
    handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.selectedGenreList", selectedValues);
    },
     
    getSelectedGenre : function(component, event, helper){
        //Get selected Genre List on button click 
        var selectedValues = component.get("v.selectedGenreList");
        console.log('Selectd Genre-' + selectedValues);
    },
    
    getMcContent : function(component, event, helper) {
        var selectedCType = component.get('v.contentType');
        var selectedMCIds = component.get('v.managedContentIds');
        var selectedTopics = component.get('v.topicNames');
        var selectedLanguage = component.get('v.language');
        var contentAction = component.get("c.getMContent");
        if(selectedMCIds){
            contentAction.setParam('managedContentIds_str', selectedMCIds);    
        }       
        contentAction.setParam('topicNames_str', selectedTopics);
        contentAction.setParam('language', 'en_US');    
        if(selectedCType){
            contentAction.setParam('contentType', selectedCType);    
        }
        contentAction.setCallback(this, function(action) {
            var state = action.getState();
            if (state === 'SUCCESS') {
                console.log("contentList data "+JSON.stringify(action.getReturnValue()));
               
                
                 component.set("v.contentList",action.getReturnValue());
            }
            else{
                console.log("Error occurrred");
            }
        });
        $A.enqueueAction(contentAction);
    },
    
    
                     
})