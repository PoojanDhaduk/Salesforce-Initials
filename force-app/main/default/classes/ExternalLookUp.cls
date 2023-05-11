public class ExternalLookUp{
    public static void relateToAccount(){
        Contact newContact = new Contact(
            FirstName='Just',
            LastName='Try');
        
        Account accountReference = new Account(ExternalID__c='SAP111211');
        newContact.Account = accountReference;   
        Account newAccountReference = new Account(Name='CheckForExternalID' , 	ExternalID__c='SAP111211');
        
        Database.SaveResult[] results = Database.insert(new SObject[] {
            newAccountReference, newContact });
    }
}