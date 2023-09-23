@isTest
public class ControllerTest {
    
    @isTest
    public static void testeController() {
        Account contaTeste = new Account();
        contaTeste.Name = 'Reirysson';
        insert contaTeste;

        Account buscaConta = [SELECT Id FROM Account];
        Contact contatoTeste = new Contact();
        contatoTeste.LastName = 'Thiago';
        contatoTeste.Phone = '(84) 96454-2464';
        contatoTeste.AccountId = buscaConta.Id;
        insert contatoTeste;

        List<ContactController.ContactTO> teste = new List<ContactController.ContactTO>();

        Test.startTest();

        teste = ContactController.buscarContatosConta(buscaConta.Id);

        Test.stopTest();
    }
}