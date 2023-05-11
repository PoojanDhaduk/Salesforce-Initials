public with sharing class CreateContactsOnAccountCreationHandler {

    public static void createContactsOnAccountCreate(List<Account> newAccounts){
        List<Contact> contactsToBeCreated = new List<Contact>();
        if(newAccounts.size()>0){
        Account newAccount = newAccounts.get(0);
            if(newAccount.Number_Of_Contacts__c !=null){
                for(Integer i=1 ; i<=newAccount.Number_Of_Contacts__c ; i++){
                    Contact contact1 = new Contact(AccountId = newAccount.Id ,FirstName =  'Contact For', LastName= newAccount.Name +' '+ i);
                    contactsToBeCreated.add(contact1);
                } 
            }
        }
        insert contactsToBeCreated;
    }
    
    public static void createContactsOnAccountUpdate(List<Account> newList , List<Account> oldList) {
        List<Contact> contactsToBeCreated = new List<Contact>();
        List<Contact> contactsToBeDeleted = new List<Contact>();
        if(newList.size()>0 && oldList.size()>0){
            Account newAccount = newList.get(0);
            Account oldAccount = oldList.get(0);
            if(newAccount.Number_Of_Contacts__c!=null && oldAccount.Number_Of_Contacts__c != null){
                if(newAccount.Number_Of_Contacts__c > oldAccount.Number_Of_Contacts__c){
                Decimal difference =newAccount.Number_Of_Contacts__c - oldAccount.Number_Of_Contacts__c;
                for(Decimal i=oldAccount.Number_Of_Contacts__c+1 ; i<=oldAccount.Number_Of_Contacts__c+difference ; i++){
                    Contact contact1 = new Contact(AccountId = newAccount.Id ,FirstName =  'Contact For', LastName= newAccount.Name+' '+i);
                    contactsToBeCreated.add(contact1);
                }
            }
            else if(oldAccount.Number_Of_Contacts__c >newAccount.Number_Of_Contacts__c){
                Integer difference =oldAccount.Number_Of_Contacts__c.intValue() - newAccount.Number_Of_Contacts__c.intValue();
                List<Contact> Extracontacts = [SELECT AccountId , LastName FROM Contact WHERE AccountId =: newAccount.Id ORDER BY LastName DESC LIMIT : difference];
                contactsToBeDeleted.addAll(Extracontacts);
            }
        }       
        }
        if(contactsToBeCreated.size()>0){
            Insert contactsToBeCreated;
        }
        if(contactsToBeDeleted.size()>0){
            Delete contactsToBeDeleted;
        }
    }
}