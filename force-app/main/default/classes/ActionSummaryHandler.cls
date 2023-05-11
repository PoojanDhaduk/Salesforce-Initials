public with sharing class ActionSummaryHandler  {
    public static void controlSummaryHandler(List<Action__c> newList){
        Set<Id> controlIds = new Set<Id>();
        for(Action__c a : newList){
            controlIds.add(a.Control__c);
        }

        //Query to Retrieve all the actions which are completed and grouping them by their parent control.
        List<AggregateResult> completedActionsList = [
            SELECT ActionType__c, SUM(Assigned_Score__c) TotalScore , Control__c ,Count(Id) Completed 
            FROM Action__c 
            WHERE status__c = 'Completed' AND Control__C IN : controlIds 
            WITH SECURITY_ENFORCED 
            Group by ActionType__c, Control__c
            ];

        //query to retrive actions by their action type and grouping them by parent control and counting values of it.


        Map<Id, AggregateResult> totalActionMapForTrigger = new Map<Id, AggregateResult>([
            SELECT COUNT(Id) totalActionCount, Control__r.Id
            FROM Action__c
            WHERE ActionType__c = 'ApexTrigger'
            GROUP BY Control__r.Id 
            ]);
        
        Map<Id, AggregateResult> totalActionMapForCoding = new Map<Id, AggregateResult>([
            SELECT COUNT(Id) totalActionCount, Control__r.Id
            FROM Action__c
            WHERE ActionType__c = 'ApexCoding'
            GROUP BY Control__r.Id 
            ]);
                
        Map<Object , List<Map<String, Object>>> controlMap = new Map<Object , List<Map<String, Object>>>();
        
        //running for loop for the records of action which are completed and we will store it to map to convert them into JSON format.
        
        for(AggregateResult act : completedActionsList){
            Map<String, Object> actionSummary = new Map<String, Object>();
            //System.debug(act.get('Control__c'));
            String controlId = (String)act.get('Control__c');
            Decimal total = 0;
            //checking for actiontype and assigning total according to it.
            if(act.get('ActionType__c') == 'ApexCoding'){
                total = (Decimal)((totalActionMapForCoding.get(controlId)).get('totalActionCount'));
            }

            else if(act.get('ActionType__c') == 'ApexTrigger'){   
                total = (Decimal)((totalActionMapForTrigger.get(controlId)).get('totalActionCount'));
            }

            actionSummary.put('Total', total); 
            actionSummary.put('AssignedScore', (Decimal)act.get('TotalScore'));
            actionSummary.put('Completed', (Decimal)act.get('Completed')); 
            actionSummary.put('ActionType', (String)act.get('ActionType__c'));
            

            if(controlMap.get(act.get('Control__C')) != null){
               List<Map<String, Object>> currentSummary = controlMap.get(act.get('Control__C'));
               currentSummary.add(actionSummary);
               controlMap.put( act.get('Control__C') , currentSummary);
            }

            else{
                List<Map<String, Object>> summaryList = new List<Map<String, Object>>();
                    summaryList.add(actionSummary);
                    controlMap.put( act.get('Control__C') ,  summaryList);
            }
        }       

        List<Control__c> controlListToUpdate = [SELECT Id , Action_Summary__c FROM Control__c WHERE ID IN :controlIds WITH SECURITY_ENFORCED];

        for(Control__c c : controlListToUpdate){
        //  String summaryJSON = JSON.serializePretty(controlMap.get(c.Id));
        String summaryJSON = JSON.serialize(controlMap.get(c.Id));
        c.Action_Summary__c = summaryJSON; 
        }       

        update controlListToUpdate;

    }



    public static void controlSummaryHandlerForAssessment(List<Action__c> newList){
        // SELECT Control__r.Assessment__c FROM Action__c

        Set<Id> controlIds = new Set<Id>();

        for (Action__c a : newList) {
            controlIds.add(a.Control__c);
        }

        List<Control__c> controls = [SELECT Id, Assessment__c FROM Control__c WHERE Id IN :controlIds];
        Set<Id> assessmentIds = new Set<Id>();
        
        for (Control__c control : controls) {
            assessmentIds.add(control.Assessment__c);
        }     

        //Query to Retrieve all the actions which are completed and grouping them by their parent control.
        List<AggregateResult> completedActionsList = [
            SELECT ActionType__c, SUM(Assigned_Score__c) TotalScore , Control__r.Assessment__c assessmentId ,Count(Id) Completed 
            FROM Action__c 
            WHERE status__c = 'Completed' AND Control__r.Assessment__c IN : assessmentIds
            WITH SECURITY_ENFORCED 
            Group by ActionType__c, Control__r.Assessment__c
            ];

        //query to retrive actions by their action type and grouping them by parent control and counting values of it.
        Map<Id, AggregateResult> totalActionMapForTrigger = new Map<Id, AggregateResult>([
            SELECT COUNT(Id) totalActionCount, Control__r.Assessment__r.Id
            FROM Action__c
            WHERE ActionType__c = 'ApexTrigger'
            GROUP BY Control__r.Assessment__r.Id
            ]);
        
        Map<Id, AggregateResult> totalActionMapForCoding = new Map<Id, AggregateResult>([
            SELECT COUNT(Id) totalActionCount, Control__r.Assessment__r.Id
            FROM Action__c  
            WHERE ActionType__c = 'ApexCoding'
            GROUP BY Control__r.Assessment__r.Id
            ]);

            // System.debug(completedActionsList);
            // System.debug(totalActionMapForCoding);
            // System.debug(totalActionMapForTrigger);

            Map<Object , List<Map<String, Object>>> assessmentMap = new Map<Object , List<Map<String, Object>>>();

            for(AggregateResult act : completedActionsList){
                Map<String, Object> actionSummary = new Map<String, Object>();
                //System.debug(act.get('Control__r.Assessment__c'));
                String assessmentId = (String)act.get('assessmentId'); 
                Decimal total = 0;

                //checking for actiontype and assigning total according to it.
                if(act.get('ActionType__c') == 'ApexCoding'){
                    total = (Decimal)((totalActionMapForCoding.get(assessmentId)).get('totalActionCount'));
                }
    
                else if(act.get('ActionType__c') == 'ApexTrigger'){   
                    total = (Decimal)((totalActionMapForTrigger.get(assessmentId)).get('totalActionCount'));
                }
    
                actionSummary.put('Total', total); 
                actionSummary.put('AssignedScore', (Decimal)act.get('TotalScore'));
                actionSummary.put('Completed', (Decimal)act.get('Completed')); 
                actionSummary.put('ActionType', (String)act.get('ActionType__c'));
                
    
                if(assessmentMap.get(act.get('assessmentId')) != null){
                   List<Map<String, Object>> currentSummary = assessmentMap.get(act.get('assessmentId'));
                   currentSummary.add(actionSummary);
                   assessmentMap.put( act.get('assessmentId') , currentSummary);
                }
    
                else{
                    List<Map<String, Object>> summaryList = new List<Map<String, Object>>();
                    summaryList.add(actionSummary);
                    assessmentMap.put( act.get('assessmentId') ,  summaryList);
                }
            }       
    
            List<Assessment__c> assessmentListToUpdate = [SELECT Id , Action_Summary__c FROM Assessment__C WHERE ID IN :assessmentIds WITH SECURITY_ENFORCED];
    
            for(Assessment__c a : assessmentListToUpdate){
            //  String summaryJSON = JSON.serializePretty(assessmentMap.get(a.Id));
            String summaryJSON = JSON.serialize(assessmentMap.get(a.Id));
            a.Action_Summary__c = summaryJSON; 
            }       
    
            update assessmentListToUpdate;
    }
}

