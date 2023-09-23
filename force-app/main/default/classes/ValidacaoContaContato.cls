public with sharing class ValidacaoContaContato {
    public static void validarCamposContato(List<Contact> listContatos) {
        for(Contact contato : listContatos) {
            if(contato.Phone == null) {
                contato.Phone.addError('Falta preencher o número de telefone');
            }
        }
    }
}