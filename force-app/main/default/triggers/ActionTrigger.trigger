trigger ActionTrigger on Action__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    //if (Org_Specific_Setting__mdt.getInstance('Run_All_Triggers')?.Value__c == true) {
        //TriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);
        Boolean isActive = TRUE;
        if(isActive){
            switch on Trigger.operationType {
                when BEFORE_INSERT {
                    //handler.beforeInsert(Trigger.new);
                }
                when BEFORE_UPDATE {
                    // handler.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
                }
                when BEFORE_DELETE {
                    // handler.beforeDelete(Trigger.old, Trigger.oldMap);
                }
                when AFTER_INSERT {
                    ActionTriggerHandler.actionSummaryHandlerForControl(Trigger.New);
                    ActionTriggerHandler.summaryHandlerforAssessment(Trigger.New);
                    // ActionTriggerHandler.controlSummaryHandlerforAssessment(Trigger.New);
                    //handler.afterInsert(Trigger.new, Trigger.newMap);
                }
                when AFTER_UPDATE {
                    ActionTriggerHandler.actionSummaryHandlerForControl(Trigger.New);
                    ActionTriggerHandler.summaryHandlerforAssessment(Trigger.New);
                    // ActionTriggerHandler.controlSummaryHandlerforAssessment(Trigger.New);
                    //handler.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
                }
                when AFTER_UNDELETE {
                    // handler.afterUndelete(Trigger.new, Trigger.newMap);
                }
                when AFTER_DELETE {
                    ActionTriggerHandler.actionSummaryHandlerForControl(Trigger.old);
                    ActionTriggerHandler.SummaryHandlerforAssessment(Trigger.old);
                    // ActionTriggerHandler.controlSummaryHandlerforAssessment(Trigger.old);
                    // handler.afterDelete(Trigger.old, Trigger.oldMap);
                }
            }
        }
    //}
}