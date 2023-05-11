public with sharing class OrderTriggerHandler {
    public static void fetchTotalAmount(List<Order> newList , Map<Id , Order> oldMap){
        Map<Id, Decimal> opportunityIdandAmountMap = new Map<Id, Decimal>();
        Map<Id, Decimal> opportunityIdandInvoicedAmountMap = new Map<Id, Decimal>();
        Map<Id, Decimal> opportunityIdandApprovedAmountMap = new Map<Id, Decimal>();

        for(Order o:newList){
            if(o.Status != oldMap.get(o.Id).Status){

                if(o.Status == 'Draft' || oldMap.get(o.Id).Status == 'Draft'){
                    if(o.Status!='Draft'){
                        opportunityIdandAmountMap.put(o.OpportunityId , o.TotalAmount);
                    }
                    else if(oldMap.get(o.Id).Status != 'Draft'){
                        opportunityIdandAmountMap.put(o.OpportunityId , -o.TotalAmount);
                    }
                }
                
                if(o.Status=='Invoiced' || oldMap.get(o.Id).Status == 'Invoiced'){
                    
                    if(o.Status=='Invoiced' && oldMap.get(o.Id).Status != 'Invoiced'){
                        opportunityIdandInvoicedAmountMap.put(o.OpportunityId , o.TotalAmount);
                    }
                    else if(oldMap.get(o.Id).Status == 'Invoiced' && o.Status !='Invoiced' ){
                        opportunityIdandInvoicedAmountMap.put(o.OpportunityId , -o.TotalAmount);
                    }
                }
                if(o.Status=='Approved' || oldMap.get(o.Id).Status == 'Approved'){
                    if(o.Status=='Approved' && oldMap.get(o.Id).Status != 'Approved'){
                        opportunityIdandApprovedAmountMap.put(o.OpportunityId , o.TotalAmount);
                    }
                    else if(oldMap.get(o.Id).Status == 'Approved' && o.Status !='Approved' ){
                        opportunityIdandApprovedAmountMap.put(o.OpportunityId , -o.TotalAmount);
                    }
                }
            } 
        }
        if(opportunityIdandInvoicedAmountMap!=Null){
            OpportunityGrandTotalHandler.updateInvoicedGrandTotal(opportunityIdandInvoicedAmountMap);
        }
        if(opportunityIdandApprovedAmountMap!=Null){ 
            OpportunityGrandTotalHandler.updateApprovedGrandTotal(opportunityIdandApprovedAmountMap);
        }
        if(opportunityIdandAmountMap!=Null){ 
            OpportunityGrandTotalHandler.updateGrandTotal(opportunityIdandAmountMap);
        }
    }
}