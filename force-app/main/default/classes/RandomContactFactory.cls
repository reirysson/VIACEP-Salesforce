public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numContatos, String sobrenomes) {
        List<Contact> listContatos = new List<Contact>();
        for(Integer i=0; i<numContatos; i++) {
            Contact contatoNovo = new Contact();
            contatoNovo.FirstName = 'Test' + i;
            contatoNovo.LastName = sobrenomes;
            listContatos.add(contatoNovo);
        }
        return listContatos;
    }
}