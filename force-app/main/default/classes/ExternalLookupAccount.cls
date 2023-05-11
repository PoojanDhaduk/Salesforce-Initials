public class ExternalLookupAccount {
    public static void newMethod(){
        Account accountref = [select name, ExternalId__c from account where ExternalId__c = 'ABC123'];
        contact contactref = [select Lastname ,AccountId, UniqueId__c from contact where UniqueId__c='GetOnDataDhiraj' ];
        contactref.AccountID = accountref.ID;
        System.debug(accountref);
        System.debug(contactref.AccountId);
        upsert contactref UniqueId__c;
    }
}