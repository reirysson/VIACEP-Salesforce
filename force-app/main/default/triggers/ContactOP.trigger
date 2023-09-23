trigger ContactOP on Contact (before update) {
    ValidacaoContaContato.validarCamposContato(Trigger.new);
}