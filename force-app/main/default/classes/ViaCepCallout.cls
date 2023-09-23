public class ViaCepCallout {

    @AuraEnabled 
    public static CEPObjTO buscarCEP(String CEP) {

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        try {
            req.setEndpoint('https://viacep.com.br/ws/'+ CEP +'/json/');
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');

            HttpResponse resp = http.send(req);
            CEPObjTO cepResposta = (CEPObjTO)JSON.deserialize(resp.getBody(), CEPObjTO.class);

            if(resp.getStatusCode() == 200) {
                return cepResposta;
            } else {
                return null;
            }
        } catch (Exception ex){
            return null;
        }
        
    }

    @AuraEnabled
    public static Boolean atualizarEnderecoConta(String idConta, String jsonResposta) {
        try {
            CEPObjTO results = (CEPObjTO)JSON.deserialize(jsonResposta, CEPObjTO.class);

            if(results.erro == true) {
                return false;
            }

            Account conta = AccountDAO.getAccountById(idConta);

            conta.BillingCity = results.localidade;
            conta.BillingCountry = 'BR';
            conta.BillingPostalCode = results.cep;            
            conta.BillingState = results.uf;
            conta.BillingStreet = results.logradouro;
            
            update conta;

            return true;

        } catch (exception e) {
            system.debug(e.getMessage());
            return false;
        }
    }

    public class CEPObjTO {
        @AuraEnabled public String cep { get; set; }
        @AuraEnabled public String localidade { get; set; }
        @AuraEnabled public String uf { get; set; }
        @AuraEnabled public String logradouro { get; set; }
        @AuraEnabled public Boolean erro { get; set; }
    }
}