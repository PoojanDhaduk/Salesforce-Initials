public class Practical1New {
    
   /* List<List<String>> contactList = new List<List<String>>{
    new List<String>{'Poojan' , 'Dhaduk'},
    new List<String>{'Prince' , 'Patel'},
    new List<String>{'Kaushal', 'Kakadiya'},
    new List<String>{'Maulik' , 'Kabariya'},
    new List<String>{'Harsh' , 'Mehta'}
};*/
    
    
    public static void createContactList(List<List<String>> contactList){
        List<contact> contactsToUpsert = new List<contact>();
        Savepoint sp = Database.setSavepoint();
        try{
            for(List<String> innerList : contactList) {
                
                String firstName = innerList[0];
                String lastName = innerList[1];
                
                String uniqueId = firstName.deleteWhitespace() + lastName.deleteWhitespace();
                
                contact newContact = new contact(FirstName = firstName , LastName =lastName , uniqueId__c = uniqueId);
                
                List<Account> accountList = [SELECT Name , ExternalID__c FROM Account WHERE ExternalID__c =: uniqueId ];
                
                for(Account acc : accountList) {
                    newContact.AccountId = acc.Id;
                }
                
                contactsToUpsert.add(newContact);
            }
            upsert contactsToUpsert UniqueId__c;
            
        }  catch (Exception e){
            
            Database.rollback(sp);
            
        }
    }   
    
}