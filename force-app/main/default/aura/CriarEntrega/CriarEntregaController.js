({
	handleSubmit: function(component, event, helper) {
		component.set('v.spinner', true);
		event.preventDefault();
		var fields = event.getParam('fields');
		component.find('recordEditForm').submit(fields);
	},

	handleSuccess: function(component, event, helper) {
		component.set('v.spinner', false);
		helper.showToast(component, event, helper, "Sucesso", "success", "Registro criado com sucesso");
	},


	handleReset: function(component, event, helper) {
		component.find('field').forEach(function(f) {
			f.reset();
		});
	}
})