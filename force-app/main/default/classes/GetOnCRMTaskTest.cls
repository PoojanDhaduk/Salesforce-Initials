@isTest
public class GetOnCRMTaskTest {
    @isTest
    private static void testMethodClass(){
        List<contact> contactsToUpsert = new List<contact>();
        for(Integer i=0; i<5; i++){
            contact newContact = new contact(FirstName = 'Poojan' , LastName ='Dhaduk'+i);
            contactsToUpsert.add(newContact);
        }
        GetOnCRMTask.createContactList(contactsToUpsert);
    }
}