public with sharing class CaseLimitHandler {
    
    public static void caseLimitRestriction(List<case> newList){

        Decimal maxCasesValue = Limit__mdt.getInstance('maxCases').MaxLimit__c;
        Set<Id> userIds = new Set<Id>();
        Map<Id, Decimal> ownerCaseCountMap = new Map<Id, Decimal>();

        for(case c : newList){
            userIds.add(c.OwnerId);
        }
        System.debug(userIds);

        List<AggregateResult> results = [SELECT OwnerId, Count(Id) FROM Case WHERE OwnerId IN : userIds  AND CreatedDate = THIS_MONTH WITH SECURITY_ENFORCED GROUP BY OwnerId]; 

        for(AggregateResult result : results) {
            ownerCaseCountMap.put((Id)result.get('OwnerId'), (Decimal)result.get('expr0'));
        }

        for(Case c : newList){
            System.debug(ownerCaseCountMap.get(c.OwnerId));
            if(ownerCaseCountMap.get(c.OwnerId)+1 > maxCasesValue){
                String ownerName = c.Owner.Name;
                c.addError('Too many cased created this month for user '+ c.OwnerId + c.CreatedBy + ' :  ' + maxCasesValue);
            }
            else{
               Decimal count = ownerCaseCountMap.get(c.OwnerId);
               ownerCaseCountMap.put(c.OwnerId , count+1 );
            }
        }
    }
}