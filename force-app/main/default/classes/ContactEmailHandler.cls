public with sharing class ContactEmailHandler {
    public static void defaultemailgenerator(List<Contact> newList){
        //System.debug('reached inside email handler');
        Set<Id> accIdSet = new Set<Id>();

        for(Contact con : newList){
            accIdSet.add(con.AccountId);
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT Id , Name FROM Account WHERE Id IN : accIdSet
        ]);
        
        for(Contact con : newList){
            if(accountMap.get(con.AccountId)!=null){
            String accountname = accountMap.get(con.AccountId).Name;
                if(emailsuffix__c.getValues(accountname).sufffixforemail__c != null){
                    String emailString = emailsuffix__c.getValues(accountname).sufffixforemail__c;
                    con.Email = con.FirstName.toLowerCase()+'.'+con.LastName.toLowerCase()+emailString;
                }
            }
        }
    }
}