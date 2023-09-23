@isTest
public class ViaCepTest {
    @isTest
    public static void testeBuscaCEP() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('cepMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        ViaCepCallout.CEPObjTO result = ViaCepCallout.buscarCEP('01001000');
        System.assertNotEquals(null, result);
        
    }

    @isTest
    public static void testeBuscaCEPErrado() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('cepMock');
        mock.setStatusCode(400);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        ViaCepCallout.CEPObjTO result = ViaCepCallout.buscarCEP('0100100000');
        Test.stopTest();

        System.assertEquals(null, result);
    }

    @isTest 
    public static void testeAtualizarEnderecoContaCorreto() {
        Account conta = new Account();
        conta.Name = 'Reirysson';
        insert conta;

        String jsonResposta = '{"cep": "59616-190", "logradouro": "Rua Santa Lúcia", "complemento": "", "bairro": "Santa Delmira", "localidade": "Mossoró", "uf": "RN", "ibge": "2408003", "gia": "", "ddd": "84", "siafi": "1759"}';

        Test.startTest();
        Boolean retorno = ViaCepCallout.atualizarEnderecoConta(conta.Id, jsonResposta);
        Test.stopTest();

        System.assertEquals(true, retorno);
    }


    @isTest 
    public static void testeAtualizarEnderecoContaIncorreto() {
        Account conta = new Account();
        conta.Name = 'Reirysson';
        insert conta;

        String jsonResposta = '"cep": "59616-190", "logradouro": "Rua Santa Lúcia", "complemento": "", "bairro": "Santa Delmira", "localidade": "Mossoró", "uf": "RN", "ibge": "2408003", "gia": "", "ddd": "84", "siafi": "1759"}';
        System.assertEquals(false, ViaCepCallout.atualizarEnderecoConta(conta.Id, jsonResposta));
    }
}