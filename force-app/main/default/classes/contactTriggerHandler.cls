public class contactTriggerHandler extends CommonTriggerHandler {
    
    
    public static Boolean triggerDisabled = FALSE;
    
    public override Boolean isDisabled(){
        return triggerDisabled;
    }    
    public override void beforeInsert(List<sObject> newList) {
        //ContactService.updateDesription((List<Contact>)newList);
        System.debug('reached inside contact handlers');
        ContactEmailHandler.defaultemailgenerator((List<Contact>)newList);
    }
    
    /*public override void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {

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
        
    }*/
}