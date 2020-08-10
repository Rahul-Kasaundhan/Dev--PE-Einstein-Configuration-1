({
    doInit : function(component, event, helper) {
        var pageReference = component.get("v.pageReference");
        var folderName =  pageReference.state.c__foldername;
        var reportName = pageReference.state.c__reportname;
        let filterVal = '';
        for(let val=0;val<6;val++){
            if(pageReference.state['c__fv'+val]!=undefined){
                filterVal+= 'fv'+val+'='+pageReference.state['c__fv'+val]+'&'; 
            }
        }
        filterVal = filterVal!=''?filterVal.substring(0,filterVal.length-1):'';
      
        console.log(' --reportName-- '+reportName+' --folderName-- '+folderName+' --filter-- '+filterVal);
        
        if(folderName!=undefined && reportName!=undefined){
            var action = component.get("c.fetchReportId");
            action.setParams({
                developerName: reportName,
                folderDeveloperName : folderName
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                debugger;
                if (state === "SUCCESS") {
                    var result =  response.getReturnValue();
                    if(result.status == 'success'){
                        let reportUrl = "/lightning/r/Report/"+result.reportId+'/view?&'+filterVal;
                        console.log('post response');
                        var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url":reportUrl
                        });
                        urlEvent.fire();
                    }else{
                        helper.showInfoToast('Error!',result.status,'error');                        
                    }
                }else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + errors[0].message);
                            helper.showInfoToast('Error!',errors[0].message,'error');                        
                        }
                    } 
                }
            });
            $A.enqueueAction(action);   
        }
        else{
            helper.showInfoToast('Error!','Both Report Name and Folder Name are Mandatory to open a Report','error');                        
        }
    }
})