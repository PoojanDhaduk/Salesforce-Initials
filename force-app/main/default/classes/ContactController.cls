public with sharing class ContactController {
    @AuraEnabled(cacheable = true)
    
    public static List<Contact> getContactList(){
        List<Contact> contactList = [SELECT Name , Email , Phone FROM Contact WHERE Email != null AND Phone != null WITH SECURITY_ENFORCED LIMIT 6 ];
        return contactList;
    }
}