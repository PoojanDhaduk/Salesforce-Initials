public class BeforeAndAfterUpdateTriggerHandler {
    public static void updatePhoneDescription(List<Account> newList , Map<Id,Account> oldMap){
        for(Account acc : newList){
            if(acc.Phone != oldMap.get(acc.Id).Phone){
                acc.Description='Mobile number updated';
            }
        }
    }
    
    public static void updateOpportunities(List<Account> newList , Map<Id,Account> oldMap){
        Map<Id , Account> accountThatChanged = new Map<Id , Account>();
        List<Opportunity> opportunityToModify = new List<Opportunity>();
        
        for(Account acc : newList){
            if(acc.Phone != oldMap.get(acc.Id).Phone){
                accountThatChanged.put(acc.Id, acc);
            }
        }
        opportunityToModify = [SELECT Id , Phone__c , accountId from Opportunity WHERE accountId IN : accountThatChanged.keySet()];
        for(Opportunity opp: opportunityToModify){
            System.debug(accountThatChanged.get(opp.accountId).Phone);
            opp.Phone__c = accountThatChanged.get(opp.accountId).Phone;
        }
        update opportunityToModify;
    }
}