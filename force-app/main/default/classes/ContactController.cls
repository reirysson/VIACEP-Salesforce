public with sharing class ContactController {

    @AuraEnabled
    public static List<ContactTO> buscarContatosConta(String idConta){

        List<ContactTO> contatoRelacionadoListTO = new List<ContactTO>();

        try{
            List<Contact> contatosList = [SELECT Id, Name, AccountId  
                                          FROM Contact 
                                          WHERE AccountId = :idConta];

            for (Contact contato : contatosList) {
                ContactTO contatoRelacionado = new ContactTO();
                contatoRelacionado.IdConta = contato.AccountId;
                contatoRelacionado.IdContato = contato.Id;
                contatoRelacionado.NomeContato = contato.Name;
                contatoRelacionadoListTO.add(contatoRelacionado);
            }
        }
        catch (Exception ex) {
            throw ex;
        }
        
        return contatoRelacionadoListTO;
    }

    public class ContactTO{
        @AuraEnabled public String IdConta { get; set; }
        @AuraEnabled public String IdContato { get; set; }
        @AuraEnabled public String NomeContato { get; set; }
    }
}