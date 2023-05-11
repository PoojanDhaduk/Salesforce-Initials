public virtual class CommonTriggerHandler implements TriggerHandlerInterface {
    public static Boolean triggerDisabled = false;
    
    //check if the trigger is disabled from transaction
    public virtual  Boolean isDisabled(){
        return triggerDisabled;
    }
    
    public virtual void beforeInsert(List<sObject> newList) {
        System.debug('Its a common Handler');
    }
    
    public virtual void afterInsert(List<sObject> newList , Map<Id, sObject> newMap) {
        
    }
    
    public virtual void beforeUpdate(List<sObject> newList, Map<Id, sObject> newMap, List<sObject> oldList, Map<Id, sObject> oldMap) {
        
    }
    
    public virtual void afterUpdate(List<sObject> newList, Map<Id, sObject> newMap,  List<sObject> oldList, Map<Id, sObject> oldMap) {
        
    }
    
    public virtual void beforeDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
        
    }
    
    public virtual void afterDelete(List<sObject> oldList , Map<Id, sObject> oldMap) {
        
    }
    
    public virtual void afterUnDelete(List<sObject> newList, Map<Id, sObject> newMap) {
        
    }
    
}