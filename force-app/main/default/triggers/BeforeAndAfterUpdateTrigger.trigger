trigger BeforeAndAfterUpdateTrigger on Account (before update, after update) {
    
    if(Trigger.isbefore){
        BeforeAndAfterUpdateTriggerHandler.updatePhoneDescription(Trigger.New , Trigger.oldMap);
    }
    else if(Trigger.isafter){
        BeforeAndAfterUpdateTriggerHandler.updateOpportunities(Trigger.New , Trigger.oldMap);
    }
    
}