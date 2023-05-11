@isTest
public class ActionSummaryHandlerTest {
    @isTest
    private static void orderTestMethod1(){
        Assessment__c newAssessment = new Assessment__c(Name ='A1');
        insert newAssessment;
        
        Control__c newControl = new Control__c(Name = 'C1');
        newControl.Assessment__c = newAssessment.Id;
        insert newControl;
        
        Action__c newAction = new Action__c(Name = 'Ac1');
        newAction.Control__c = newControl.Id;
        newAction.Assigned_score__c = 5;
        newAction.ActionType__c = 'ApexTrigger';
        newAction.Status__c = 'Completed';
        insert newAction;
        
        Action__c newAction1 = new Action__c(Name = 'Ac11');
        newAction1.Control__c = newControl.Id;
        newAction1.Status__c = 'In-Process';
        insert newAction1;
        newAction1.Status__c = 'Completed';
        update newAction1;
        
        Action__c newAction2 = new Action__c(Name = 'Ac11');
        newAction2.Control__c = newControl.Id;
        newAction2.Status__c = 'Completed';
        insert newAction2;

        delete newAction2;

        Assessment__c testingAssessment = [SELECT Id , Action_Summary__c FROM Assessment__c WHERE ID =: newAssessment.Id];
        System.assertEquals(TRUE , testingAssessment.Action_Summary__c != null , 'Success');
    }
}