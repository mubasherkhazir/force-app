({
    doInit : function(component, event, helper) {
        
        var action=component.get("c.getStageName");
        action.setCallback(this,function(response){
            if('SUCCESS'===response.getState()){
                console.log('state success');
                
                component.set('v.stageNameList',response.getReturnValue());
                console.log('Stage Name List +++++++++++++'+response.getReturnValue())
                
            }else{
                console.log('state failed');
            }
            
            
        });
        $A.enqueueAction(action);
        var list=component.get('v.opportunityList');
        var id=component.get('v.recordId');
        var c ={
            Name: "",
            CloseDate:"",
            StageName: '',
            AccountId: id
        }
        console.log(c);
        
        list.push(c);
        component.set('v.opportunityList',list);
    },
    
    addItem : function(component, event, helper) {
        
        var list=component.get('v.opportunityList');
        console.log('opoooooo '+JSON.stringify(list));
                var id=component.get('v.recordId');

        var c ={
            
            Name: "",
            CloseDate:"",
            StageName:"",
            AccountId: id
            
        }
        
        
        list.push(c);
        component.set('v.opportunityList',list);
    },
    
    save :  function(component, event, helper) {
        var lst=component.get("v.opportunityList");
        console.log("OPPPPPPPPPPPPPPP "+JSON.stringify(lst));
        var action=component.get('c.insertOpportunitiesList');
        
        var lst2=JSON.stringify(lst);
        action.setParams({
            "obj" : lst2 
        });
        action.setCallback(this,function(response){
            if('SUCCESS'===response.getState()){
                if(response.getReturnValue()===true){
                    console.log('success');
                }
                else{
                    alert('failed');
                }
            }
            else{
                console.log('error');
            }
        });
        $A.enqueueAction(action);
    },
    removeRow: function(component, event, helper) {
        var opList = component.get("v.opportunityList");
        var selectedItem = event.currentTarget;
        var index = selectedItem.dataset.record;
        opList.splice(index, 1);
        component.set("v.opportunityList",opList);
    },
    
})