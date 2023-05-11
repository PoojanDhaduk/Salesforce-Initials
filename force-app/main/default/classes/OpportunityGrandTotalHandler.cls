public with sharing class OpportunityGrandTotalHandler {

    public static void updateGrandTotal(Map<Id , Decimal> oppIdDiffMap){
        Map<Id , Opportunity> oppMap = New Map<Id,Opportunity>([SELECT Id , Name , GrandTotal_All_Orders__c FROM Opportunity WHERE Id IN :oppIdDiffMap.keySet()]);
        for(String key : oppIdDiffMap.keySet()){
            Opportunity opp = oppMap.get(Key);
            //System.debug(oppIdDiffMap.get(key));
            opp.GrandTotal_All_Orders__c = opp.GrandTotal_All_Orders__c + oppIdDiffMap.get(key);
        }
        //System.debug(oppMap);

        try {
            Database.Update (oppMap.values() , false);
        } catch (DmlException e) {
            System.debug('An error occurred: ' + e.getMessage());
        } 
        
    }

    public static void updateInvoicedGrandTotal(Map<Id , Decimal> oppIdDiffMap){
        Map<Id , Opportunity> oppMap = New Map<Id,Opportunity>([SELECT Id , Name , GrandTotal_Invoiced__c FROM Opportunity WHERE Id IN :oppIdDiffMap.keySet()]);
        for(String key : oppIdDiffMap.keySet()){
            Opportunity opp = oppMap.get(Key);
           // System.debug(oppIdDiffMap.get(key));
            opp.GrandTotal_Invoiced__c = opp.GrandTotal_Invoiced__c + oppIdDiffMap.get(key);
        }
        //System.debug(oppMap);

        try {
            Database.Update (oppMap.values() , false);
        } catch (DmlException e) {
            System.debug('An error occurred: ' + e.getMessage());
        } 
    }

    public static void updateApprovedGrandTotal(Map<Id , Decimal> oppIdDiffMap){
        Map<Id , Opportunity> oppMap = New Map<Id,Opportunity>([SELECT Id , Name , GrandTotal_Approved__c FROM Opportunity WHERE Id IN :oppIdDiffMap.keySet()]);
        for(String key : oppIdDiffMap.keySet()){
            Opportunity opp = oppMap.get(Key);
          //  System.debug(oppIdDiffMap.get(key));
            opp.GrandTotal_Approved__c = opp.GrandTotal_Approved__c + oppIdDiffMap.get(key);
        }
        //System.debug(oppMap);

        try {
             Database.Update (oppMap.values() , false);
        } catch (DmlException e) {
           System.debug('An error occurred: ' + e.getMessage());
        } 
    }
    
}