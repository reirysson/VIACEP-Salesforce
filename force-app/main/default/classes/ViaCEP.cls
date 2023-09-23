public class ViaCEP {
    @AuraEnabled
    public static String consultaJSON(String cep) {
        HttpRequest req = new HttpRequest();
        cep = cep.replace('-','');
        req.setEndpoint('https://viacep.com.br/ws/'+ cep + '/json/');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(12000);

        try {
            Http h = new Http();
            HttpResponse res = h.send(req);

            System.debug('JSON retornado' + res.getBody());

            if(res.getStatusCode() == 200) {
                System.debug(res.getBody());
                ObjViaCep dados = parse(res.getBody());
                System.debug(dados);

                if(dados.erro == true) {
                    return 'erro';
                } 
                return 'sucesso';
            }
        } catch (Exception ex) {
            System.debug(ex.getMessage());
            return 'erro';
        }

        return null;
    }

    public class ObjViaCep {
        public String cep;
        public String logradouro;
        public String bairro;
        public String localidade;
        public String uf;
        public Boolean erro;
    }

    public static ObjViaCep parse(String json) {
        ObjViaCep viaCep = (ObjViaCep) System.JSON.deserialize(json, ObjViaCep.class);

        return viaCep;
    }
}