({
    buscarCep : function(component) {
        
        var action = component.get("c.buscarCEP");
        action.setParams({ 
            CEP : component.get("v.cep") }); 
        
        action.setCallback(this, function(response) {
            component.set("v.corpoCep", response.getReturnValue());
            
            if (response.getState() === "SUCCESS" && component.get("v.corpoCep.erro") == null) {                                        
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({            
                    "message": "CEP encontrado",
                    "type":"success"
                });
                toastEvent.fire();
                                
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "message": "CEP não encontrado",
                    "type":"error"
                });
                toastEvent.fire();
            }
        });       
        
        $A.enqueueAction(action);
	},
    
    salvarEndereco : function(component) {
        
        var action = component.get("c.atualizarEnderecoConta");
        action.setParams({ 
            idConta : component.get("v.recordId"), 
            jsonResposta : JSON.stringify(component.get("v.corpoCep")) 
        });        
        
        action.setCallback(this, function(response) {
            component.set("v.corpoCep", response.getReturnValue());
                    
            if (response.getState() === "SUCCESS" && component.get("v.corpoCep")) {     
                if(response.getReturnValue()) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "message": "Endereço atualizado",
                        "type":"success"
                   	 });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();                    
                }            
            } else {              
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "message": "Endereço não atualizado",
                        "type":"error"
                    });
                    toastEvent.fire();
                } 
        });       
        $A.enqueueAction(action);
	},
    
    cancelar : function() {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
            dismissActionPanel.fire();
	},   
})