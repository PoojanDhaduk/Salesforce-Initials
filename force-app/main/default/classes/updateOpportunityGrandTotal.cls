public class updateOpportunityGrandTotal {
    public static void addOrderAmount(List<Order> newList, Map<id , Order> newMap){

        // List<id> opportunityIds = new List<Id>();
        // List<Opportunity> opportunityToUpdate = new List<Opportunity>();
        
        // for(Order o : newList){
        //     OpportunityIds.add(o.OpportunityId);
        // } 
        // Map<Id ,Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id ,Name , GrandTotal_All_Orders__c FROM Opportunity WHERE Id IN :OpportunityIds]);
        // for(Order o:newList){
        //     Opportunity opp = oppMap.get(o.OpportunityId);
        //     opp.GrandTotal_All_Orders__c = opp.GrandTotal_All_Orders__c + o.TotalAmount;
        //     opportunityToUpdate.add(opp);
        // }
        // update opportunityToUpdate;
    }
    /*public static void modifyOrderAmount(List<Order> oldList , List<Order> newList , Map<Id,Order> oldMap , Map<Id , Order> newMap){
        List<id> opportunityIds = new List<Id>();
        List<Opportunity> opportunityToUpdate = new List<Opportunity>();
        System.debug('running inside modifyMethod');
        for(Order o : newList){
            OpportunityIds.add(o.OpportunityId);
        } 
        System.debug(opportunityIds);
        Map<Id ,Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id ,Name , GrandTotal_All_Orders__c FROM Opportunity WHERE Id IN :OpportunityIds]);
        for(Order o:newList){
            if(o.TotalAmount != oldMap.get(o.Id).TotalAmount){
            Opportunity opp = oppMap.get(o.OpportunityId);
            opp.GrandTotal_All_Orders__c = opp.GrandTotal_All_Orders__c + o.TotalAmount;
            System.debug(opp.GrandTotal_All_Orders__c);
            opportunityToUpdate.add(opp);
          
        }
        update opportunityToUpdate;
    }*/
    public static void modifyOrderAmount(List<Order> oldList , List<Order> newList , Map<Id,Order> oldMap , Map<Id , Order> newMap){
        Set<id> opportunityIds = new Set<Id>();
        List<Opportunity> opportunityToUpdate = new List<Opportunity>();
        System.debug('running inside modifyMethod');
        for(Order o : newList){
            if(o.Status != 'Draft'){
                OpportunityIds.add(o.OpportunityId);
            }
        } 
        System.debug(opportunityIds);
        Map<Id, AggregateResult> OppIdandTotalMap = new Map<Id, AggregateResult>([
            SELECT OpportunityId Id, SUM(TotalAmount) total
            FROM Order
            WHERE OpportunityId IN :opportunityIds AND Status != 'Draft'
            GROUP BY OpportunityId
        ]);
        System.debug(OppIdandTotalMap);
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE Id In : opportunityIds];
        for (Opportunity opp : opps) {
            opp.GrandTotal_All_Orders__c = (Decimal)OppIdandTotalMap.get(opp.Id).get('total');
        }
        update opps;
    }

    public static void subtractOrderAmount(List<Order> oldList , Map<Id , Order> oldMap){
      /*  Map<id , Decimal> opportunityIdMap = new Map<Id , Decimal>();
        List<Opportunity> opportunityToUpdate = new List<Opportunity>();
        System.debug('running inside Subtract Method');
        for(Order o : oldList){
            if(o.Status != 'Draft'){
                OpportunityIdMap.put(o.OpportunityId , o.TotalAmount);
            }
        } 
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE Id In : opportunityIdMap.keySet()];
        for (Opportunity opp : opps) {
            opp.GrandTotal_All_Orders__c =  opp.GrandTotal_All_Orders__c - (Decimal)opportunityIdMap.get(opp.Id);
        }
        System.debug(opps);
        update opps;*/

    }

}