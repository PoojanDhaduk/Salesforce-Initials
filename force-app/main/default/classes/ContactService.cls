public class ContactService {
    public static void updateDesription(List<Contact> newList){
        for(contact con:newList){
            con.description ='Created New Contact';
        }
    }
}