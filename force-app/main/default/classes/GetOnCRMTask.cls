public class GetOnCRMTask {
    public static void createContactList(List<contact> contactsToUpsert){
        Savepoint sp = Database.setSavepoint();
        try{
            for(contact con : contactsToUpsert) {
               
                String uniqueId = con.FirstName.deleteWhitespace() + con.LastName.deleteWhitespace();
                con.UniqueId__c= uniqueId;
                
                List<Account> accountList = [SELECT Name , ExternalID__c FROM Account WHERE ExternalID__c =: uniqueId ];
                
                for(Account acc : accountList) {
                    con.AccountId = acc.Id;
                }
            }
            upsert contactsToUpsert UniqueId__c;
            
        }  catch (Exception e){
            
            Database.rollback(sp);
            
        }
    } 
}