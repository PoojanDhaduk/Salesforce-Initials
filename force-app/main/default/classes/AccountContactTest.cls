@isTest (seeAllData = FALSE)
public class AccountContactTest {
	
    private static testMethod void testMethod1(){
       Account newAccount1 = new Account(Name='Testing Account' , Number_Of_Contacts__c = 3);
   	   Insert newAccount1;
       Account insertedAccount = [SELECT Name , Number_of_Contacts__c FROM Account WHERE Name='Testing Account'];
        insertedAccount.Number_Of_Contacts__c=5;
        update insertedAccount;
        insertedAccount.Number_Of_Contacts__c =2;
        update insertedAccount;
    }
}