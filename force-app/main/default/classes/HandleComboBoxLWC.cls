public with sharing class HandleComboBoxLWC {
    
    @AuraEnabled(cacheable = true)
    public static List<Account>  getAccounts(){
        List<Account> accList =[SELECT Id , Name FROM Account WHERE Active__c != null WITH SECURITY_ENFORCED];
        return accList;
    }   

    @AuraEnabled
    public static List<Contact> getRelatedContacts(String accId){
        List<Contact> conList = [SELECT  FirstName , LastName FROM Contact WHERE AccountId =: accId WITH SECURITY_ENFORCED];
        return conList;
    }
}
