public class OpportunityTriggerHandler extends CommonTriggerHandler {
    
    
    public static Boolean TriggerDisabled = TRUE;
    
    public override Boolean isDisabled(){
        return TriggerDisabled;
    }    
    public override void beforeInsert(List<sObject> newList) {
        // OpportunityMethods.updateDesription(List<Opportunity>) newList);
        /*System.debug('Inside Override BeforeInsert Method');
        List<Opportunity> opportunityList = new List<Opportunity>();
        for (sObject record : newList) {
            Opportunity opp = (Opportunity)record;
            opportunityList.add(opp);
        }*/
       // List<opportunity> opportunityList = (List<Opportunity>)newList;
        OpportunityService.updateDesription((List<Opportunity>)newList);
        
    }
    
    public override void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
        OpportunityService.afterInsertMethod((Map<Id , Opportunity>)newMap);
    }
    
    public override void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
        
    }
    
    public override void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
        
    }
    
    public override void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
        
    }
    
    public override void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
        
    }
    
    public override void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
        
    }
}