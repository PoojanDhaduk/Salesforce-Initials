/*
List<Contact> contactsToUpsert = new List<Contact>();
Contact contact1= new Contact(FirstName = 'Jiten',LastName='Khatri');
contactsToUpsert.add(contact1);
GetOnCRMTask2.createContactList(contactsToUpsert , 'SAP111111');
*/


public class GetOnCRMTask2 {
    public static void createContactList(List<contact> contactsToUpsert ,String accountExternalId){
        if(contactsToUpsert.size()>0 && accountExternalId != null){
            List<contact> contactList = new List<contact>();
            
            Map<String , Contact> contactsMap = new Map<String , Contact>();
            Map<String , Account> accountsMap = new Map<String , Account>();
            Account accountReference = new Account(ExternalID__c=accountExternalId);

            for(contact con : contactsToUpsert) {
                String uniqueId = con.FirstName.deleteWhitespace() + con.LastName.deleteWhitespace(); 
                //contact con1 = new Contact();
                con.uniqueId__c = uniqueId;
                con.Account = accountReference;
                
               // Account accountReference = new Account(ExternalID__c=accountExternalId);
            }
            upsert contactsToUpsert uniqueId__c;
           /* List<Contact> existingContacts = [SELECT FirstName, LastName, UniqueId__c FROM Contact WHERE UniqueId__c != null];
            
            if(existingContacts.size()>0){
                for (Contact con : existingContacts) {
                    String uniqueId = con.FirstName.deleteWhitespace() + con.LastName.deleteWhitespace(); 
                    contactsMap.put(uniqueId, con);
                }
            }
            
            List<Account> accountToRelate = [SELECT ExternalId__c FROM Account WHERE ExternalId__c =: accountExternalId];
            
            if(contactsToUpsert.size()>0){
                for(contact con : contactsToUpsert) {
                    String uniqueId = con.FirstName.deleteWhitespace() + con.LastName.deleteWhitespace(); 
                    if(contactsMap.containsKey(uniqueId)){
                        contact contact1 = contactsMap.get(uniqueId); 
                        if(accountToRelate.size()>0){

                            Account accountReference = new Account(ExternalID__c=accountExternalId);
                            contact1.account = accountReference;

                        }
                        
                        contactList.add(contact1);
                    }
                    else{
                        contact contact1 = new Contact(FirstName = con.FirstName, LastName = con.LastName , uniqueId__c = uniqueId );
                        
                        if(accountToRelate.size()>0){
                            Account accountReference = new Account(ExternalID__c=accountExternalId);
                            contact1.account = accountReference;
                        }
                        
                        contactList.add(contact1);
                    }
                }
            }
            Savepoint sp = Database.setSavepoint();
            
            try{            
                upsert contactList uniqueId__c;
                
            } catch (Exception e){
                
                Database.rollback(sp); 
                System.debug(e.getMessage());
            }*/
        } 
        
    }
}