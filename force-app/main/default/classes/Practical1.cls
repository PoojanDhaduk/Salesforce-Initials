//List<String> nameList = new List<String>{'Poojan' , 'Smit' , 'Prince'};


public class Practical1 {
    public static void createAccountAndContact(String accountName , List<String> nameList){
        if(accountName != ''){
            
            account newAccount = new account(name=accountName);
            insert newAccount;
            
            List<contact> newContacts = new List<contact>();
            
            for(Integer i=0 ; i<nameList.size() ; i++){
                String uniqueId = accountName+nameList[i];
                contact newContact = new contact(FirstName= accountName , LastName=nameList[i] ,UniqueId__c = uniqueId.deleteWhitespace(),  AccountId=newAccount.Id);
                newContacts.add(newContact);
     	       }
            
            upsert newContacts UniqueId__c;
        }
    }
}