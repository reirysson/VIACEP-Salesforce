//Reirysson teste
public with sharing class AccountDAO {
    public static Account getAccountById(Id idConta) {
        return [
            SELECT 
                Id,
                BillingCity,
                BillingCountry,  
                BillingPostalCode, 
                BillingState                                                  
            FROM Account 
            WHERE Id =: idConta
        ];
    }
}