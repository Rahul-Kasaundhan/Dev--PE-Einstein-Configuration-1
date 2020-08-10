({
    showInfoToast : function(title,message,type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: message,
            duration:' 5000',
            type: type,
            mode: 'dismissible'
        });
        if(toastEvent){
            toastEvent.fire();
        }else{
            alert(message);
        }
    }
})