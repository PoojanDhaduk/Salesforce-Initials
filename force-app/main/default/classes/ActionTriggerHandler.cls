public with sharing class ActionTriggerHandler{
    public static void actionSummaryHandlerForControl(List<Action__c> newList){
        Set<Id> controlIds = new Set<Id>();
        for(Action__c a : newList){
            controlIds.add(a.Control__c);
        }

        List<AggregateResult> completedActionsList = [
            SELECT ActionType__c groupedBy, SUM(Assigned_Score__c) TotalScore , Control__c recordId,Count(Id) Completed
            FROM Action__c 
            WHERE status__c = 'Completed' AND Control__C IN : controlIds 
            WITH SECURITY_ENFORCED      
            Group by ActionType__c, Control__c 
        ];

        List<AggregateResult> totalActionCount = [
            SELECT COUNT(Id) totalActions, Control__r.Id recordId, ActionType__c groupedBy
            FROM Action__c
            WHERE Control__C IN : controlIds
            WITH SECURITY_ENFORCED 
            GROUP BY ActionType__c ,Control__r.Id 
        ];                

        ActionTriggerHelper summaryGeneratorInstance = new ActionTriggerHelper();
        Map<Object , List<Map<String, Object>>> recordMap =  summaryGeneratorInstance.summaryGenerator(totalActionCount ,completedActionsList , 'ActionType' );

        List<Control__c> controlListToUpdate = [SELECT Id , Action_Summary__c 
            FROM Control__c 
            WHERE ID IN :controlIds 
            WITH SECURITY_ENFORCED
        ];  

        for(Control__c c : controlListToUpdate){
            String summaryJSON = JSON.serializePretty(recordMap.get(c.Id));
            c.Action_Summary__c = summaryJSON; 
        } 

        update controlListToUpdate;
    }


    public static void summaryHandlerforAssessment(List<Action__c> newList){
        Set<Id> controlIds = new Set<Id>();

        for (Action__c a : newList) {
            controlIds.add(a.Control__c);
        }

        List<Control__c> controls = [SELECT Id, Assessment__c FROM Control__c WHERE Id IN :controlIds WITH SECURITY_ENFORCED];
        Set<Id> assessmentIds = new Set<Id>();
        
        for (Control__c control : controls) {
            assessmentIds.add(control.Assessment__c);
        }

        //for action summary
        List<AggregateResult> completedActionsListForActionSummary = [
            SELECT ActionType__c groupedBy, SUM(Assigned_Score__c) TotalScore , Count(Id) Completed , Control__r.Assessment__c recordId
            FROM Action__c 
            WHERE status__c = 'Completed' AND Control__r.Assessment__c IN : assessmentIds
            WITH SECURITY_ENFORCED      
            Group by ActionType__c,Control__r.Assessment__c
        ];

        List<AggregateResult> totalActionCountForActionSummary = [
            SELECT COUNT(Id) totalActions, ActionType__c groupedBy, Control__r.Assessment__c recordId
            FROM Action__c
            WHERE Control__r.Assessment__c IN : assessmentIds
            WITH SECURITY_ENFORCED 
            GROUP BY ActionType__c ,Control__r.Assessment__c
        ];     

        //for control summary
        List<AggregateResult> completedActionsListForControlSummary = [
            SELECT count(Id) completed ,SUM(Assigned_score__c) totalScore, Control__r.ControlFamily__c groupedBy, Control__r.Assessment__c recordId 
            FROM Action__c  
            WHERE Status__C = 'Completed' AND Control__r.Assessment__c IN : assessmentIds
            WITH SECURITY_ENFORCED
            GROUP BY Control__r.ControlFamily__c ,Control__r.Assessment__c
        ];  

        List<AggregateResult> totalActionCountForControlSummary = [
            SELECT COUNT(Id) totalActions, Control__r.ControlFamily__c groupedBy , Control__r.Assessment__c recordId
            FROM Action__c 
            WHERE Control__r.Assessment__c IN : assessmentIds
            WITH SECURITY_ENFORCED
            GROUP BY Control__r.ControlFamily__c ,Control__r.Assessment__c
        ]; 

        ActionTriggerHelper summaryGeneratorInstance = new ActionTriggerHelper();
        Map<Object , List<Map<String, Object>>> recordMapForActionSummary =  summaryGeneratorInstance.summaryGenerator(totalActionCountForActionSummary ,completedActionsListForActionSummary , 'ActionType' );   
          
        Map<Object , List<Map<String, Object>>> recordMapForControlSummary =  summaryGeneratorInstance.summaryGenerator(totalActionCountForControlSummary ,completedActionsListForControlSummary , 'ActionType' );     

        List<Assessment__c> assessmentListToUpdate = [SELECT Id , Action_Summary__c FROM Assessment__c WHERE ID IN :assessmentIds WITH SECURITY_ENFORCED];

        for(Assessment__c a : assessmentListToUpdate){
            String actionsummaryJSON = JSON.serializePretty(recordMapForActionSummary.get(a.Id));
            String controlsummaryJSON = JSON.serializePretty(recordMapForControlSummary.get(a.Id));
            a.Action_Summary__c = actionsummaryJSON; 
            a.Control_Summary__c = controlsummaryJSON;
        }       

       update assessmentListToUpdate;
    }
}