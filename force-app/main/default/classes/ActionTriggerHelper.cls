public with sharing class ActionTriggerHelper {
   public Map<Object , List<Map<String, Object>>> summaryGenerator(List<AggregateResult> recordCountList , List<AggregateResult> completedActionsList , String groupedBy){
    
    Map<String, AggregateResult> completedActionsController = new Map<String , AggregateResult>();
    for(AggregateResult a : completedActionsList){
        String newKey = (String)a.get('recordId') + (String)a.get('groupedBy');
        completedActionsController.put(newKey , a);
    }

    Map<Object , List<Map<String, Object>>> recordMap = new Map<Object , List<Map<String, Object>>>();      
    for(AggregateResult act : recordCountList){

        Map<String, Object> actionSummary = new Map<String, Object>();
        String recordId = (String)act.get('recordId');
        String groupingText = (String)act.get('groupedBy');
        String idToFind = recordId + groupingText;

        actionSummary.put('Total', act.get('totalActions')); 
        if(completedActionsController.get(idToFind) != null){
            actionSummary.put('AssignedScore', (Decimal)(completedActionsController.get(idToFind)).get('TotalScore'));
            actionSummary.put('Completed', (Decimal)(completedActionsController.get(idToFind)).get('Completed')); 
        }
        else{
            actionSummary.put('AssignedScore', 0);
            actionSummary.put('Completed', 0); 
        }
        actionSummary.put(groupedBy, groupingText);

        if(recordMap.get(recordId) != null){
           List<Map<String, Object>> currentSummary = recordMap.get(recordId);
           currentSummary.add(actionSummary);
           recordMap.put( recordId , currentSummary);
        }

        else{
            List<Map<String, Object>> summaryList = new List<Map<String, Object>>();
            summaryList.add(actionSummary);
            recordMap.put( recordId ,  summaryList);
        }
    }    
    return recordMap;

   }
}