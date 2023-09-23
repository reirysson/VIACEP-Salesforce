@isTest
public class TestRestrictContactByName {
    @isTest
    public static void testContact() {
        Contact contato = new Contact();
        contato.LastName = 'INVALIDNAME';

        test.startTest();
        Database.SaveResult result = Database.insert(contato, false);
        test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result.getErrors()[0].getMessage());
    }
}