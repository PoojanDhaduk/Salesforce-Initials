@isTest
public class GetOnCRMTask2Test {
    @testSetup
    private static void setup(){
        List<Account> accList = new List<Account>();
        Account account1 = new Account(Name='India' , ExternalId__c = 'IND23032023');
        accList.add(account1);
        insert accList;
        List<Contact> conList = new List<Contact>();
        Contact contact1 = new Contact(FirstName='Virat',LastName='Kohli' , UniqueId__c = 'ViratKohli');
        conList.add(contact1);
        insert conList;   
    }
    private static testMethod void GOCTestMethod1(){
        
        List<Contact> contactsToUpsert = new List<Contact>();
        contact contact1=new contact(FirstName='Virat', LastName='Kohli');
        contact contact2=new contact(FirstName='Amit', LastName='Shah');
        contact contact3=new contact(FirstName='Mahendra', LastName='Dhoni');
        
        contactsToUpsert.add(contact1);
        contactsToUpsert.add(contact2);
        contactsToUpsert.add(contact3);

        
        GetOnCRMTask2.createContactList(contactsToUpsert , 'IND23032023');
        System.assertEquals('Virat', contact1.FirstName);
    }
    private static testMethod void GOCTestMethod2(){
        
        List<Contact> contactsToUpsert = new List<Contact>();
        
        GetOnCRMTask2.createContactList(contactsToUpsert , '1');
    }
}