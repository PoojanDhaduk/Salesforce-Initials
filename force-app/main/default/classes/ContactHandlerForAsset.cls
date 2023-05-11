public with sharing class ContactHandlerForAsset {
    @AuraEnabled
    public static List<Contact> getContacts(){
        List<Contact> conList = [SELECT LastName From Contact WHERE Asset__c = null WITH SECURITY_ENFORCED LIMIT 100];
        System.debug(conList);
        return conList;
    }

    @AuraEnabled
    public static void assignAsset(List<Id> listOfIds , Id assetId){
        System.debug('hello');
        List<Contact> conlist = [SELECT Asset__c FROM Contact WHERE Id IN : listOfIds WITH SECURITY_ENFORCED];
        for(Contact con : conlist){
            System.debug(con);
            con.Asset__c = assetId;
        }
            update conlist;
    }
}