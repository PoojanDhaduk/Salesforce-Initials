public with sharing class orderItemHandler {

    public static void updateOpportunityTotalAmount(List<OrderItem> newList , Map<Id,OrderItem> oldMap){

        Map<Id , Decimal> orderIdDiffMap = new Map<Id , Decimal>();
        Map<Id , Decimal> opportunityIdTotalDiffMap = new Map<Id , Decimal>();
        Map<Id , Decimal> opportunityIdApprovedDiffMap = new Map<Id , Decimal>();
        Map<Id , Decimal> opportunityIdInvoicedDiffMap = new Map<Id , Decimal>();

        //we will find the difference between new and old total amount in order Item and then store it in map with order Id.
        for(orderItem oi : newList){
            if(oi.TotalPrice!= oldMap.get(oi.Id).TotalPrice){
                Decimal difference = oi.TotalPrice - oldMap.get(oi.Id).TotalPrice;
                orderIdDiffMap.put(oi.orderId , difference);
            }
        }

        List<Order> orderList = [Select Id , OpportunityId ,Status , TotalAmount FROM Order WHERE Id IN : orderIdDiffMap.keySet() AND Status != 'Draft' WITH SECURITY_ENFORCED];

        //Making opportunity map with opportunity id and difference to reflect in opportunity.
        for(Order o :orderList){
            Decimal difference = orderIdDiffMap.get(o.Id);
            opportunityIdTotalDiffMap.put(o.OpportunityId , difference);
            if(o.Status == 'Approved' || o.Status == 'Invoiced'){
                if(o.Status == 'Approved'){
                    opportunityIdApprovedDiffMap.put(o.OpportunityId, difference);
                }
                else if(o.Status == 'Invoiced'){
                    opportunityIdInvoicedDiffMap.put(o.OpportunityId, difference);
                }
            }
            
        }
        if(opportunityIdTotalDiffMap!=Null){
            OpportunityGrandTotalHandler.updateGrandTotal(opportunityIdTotalDiffMap);  
        }
        if(opportunityIdApprovedDiffMap!=Null){
            OpportunityGrandTotalHandler.updateApprovedGrandTotal(opportunityIdApprovedDiffMap);
        }
        if(opportunityIdInvoicedDiffMap!=Null){
            OpportunityGrandTotalHandler.updateInvoicedGrandTotal(opportunityIdInvoicedDiffMap);
        }
    }
}