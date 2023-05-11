public class ApexHoursTask {
    public static void newMethod(){
    //Task 1.Write a method to insert an Account record. Also insert five related contacts to that same account.
	//Task 2.Write a SOQL query to fetch the contact records that were inserted in previous question.
	//3.Write a query on Contact object and fetch the Account details. Use child to parent relationship query.
    //4.Write a query on Account object and fetch the related contacts. Use the parent to child relationship query.

     Account acct = new Account(Name='poojan' , Active__c = 'yes');
        insert acct;
        List<Contact> newcontacts = new List<contact>();
        for(Integer i=1 ; i<6 ; i++){
             Contact con = new Contact(
             LastName='poojan' + i,
             AccountId=acct.id);
            newcontacts.add(con);
        }
        insert newcontacts;
        
        
       List<Contact> createdContacts = [select LastName FROM contact where CreatedDate  = today];
        System.debug(createdContacts);
      
      List<contact> childtoparent = [SELECT LastName , Account.Name , Account.active__c from Contact WHERE createddate = today];
   		System.debug(childtoparent);
        
        List<Account> parenttochild = [SELECT Name, (SELECT LastName from contacts) from Account WHERE createddate = today];
        System.debug(parenttochild);
    }
}