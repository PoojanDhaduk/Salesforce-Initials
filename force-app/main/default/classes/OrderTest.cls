@isTest
public class OrderTest {
    @isTest
    private static void orderTestMethod1(){

        // Created an account
        Account acc = new Account(Name ='Testing Account');
        insert acc;

        //Created An Opportunity
        Opportunity opp = new Opportunity(
            AccountId =acc.Id,Name = 'Test Opportunity',
            StageName = 'Closed Won' ,
            //GrandTotal_Invoiced__c = 0,
            //GrandTotal_Approved__c = 0,
            CloseDate = Date.today()+10);
        insert opp;
        
        // Get the standard pricebook ID
        Id pricebookId = Test.getStandardPricebookId();
        
        // Create a newproduct
        Product2 product = new Product2();
        product.Name = 'Test Product';
        product.IsActive = true;
        insert product;
        
        // Create   pricebook entry for the product in the standard pricebook
        PricebookEntry pbEntry = new PricebookEntry();
        pbEntry.Product2Id = product.Id;
        pbEntry.Pricebook2Id = pricebookId;
        pbEntry.UnitPrice = 10;
        insert pbEntry;
        
        // Create an order
        Order order = new Order();
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        order.Pricebook2Id = pricebookId;
        order.OpportunityId = opp.Id;
        order.AccountId = acc.Id;
        insert order;
        
        // Create an order item and set the PricebookEntryId field to the ID of the pricebook entry we just created
        OrderItem orderItem = new OrderItem();
        orderItem.OrderId = order.Id;
        orderItem.PricebookEntryId = pbEntry.Id;
        orderItem.Quantity = 1;
        orderItem.UnitPrice = pbEntry.UnitPrice;
        orderItem.Product2Id = product.Id;
        insert orderItem;
        
        if(order.Status == 'Draft' || order.Status == 'Approved'){
            order.Status = 'Invoiced';
        }
        
        update order;
        System.debug(order.status);   
        
        if(order.Status == 'Invoiced'){
            order.Status = 'Approved';
        }
        
        update order;
        Opportunity opportunity1 = [SELECT id , GrandTotal_Approved__c FROM Opportunity WHERE Id =: opp.Id];
        System.assertEquals(10 , opportunity1.GrandTotal_Approved__c );
        orderItem.Quantity =2;
        update orderItem;

		
    }
}