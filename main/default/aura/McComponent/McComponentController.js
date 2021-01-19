({
    myAction : function(component, event, helper) {
         
    },
    do_init : function(component, event, helper) {
        var topicsList = component.get('v.topicsList');
        var topicNamesListStr = "";
        for(var i=0;i<topicsList.length;i++){
            if(topicNamesListStr === ""){
                topicNamesListStr = topicsList[i].name;
            }
            else{
                topicNamesListStr = topicNamesListStr +" , "+topicsList[i].name;    
            }
        }
        component.set("v.topicsListStr",topicNamesListStr);
    }
})