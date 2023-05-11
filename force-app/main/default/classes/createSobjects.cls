public with sharing class createSobjects {
    public createSobjects() {
       System.debug('object Created');
    }
    public void newMethod(){
     /*   Account acc = new Account(Name='Poojan', Phone='9876076');
        Student__c stu1 = new Student__c(Name='Raju');*/
        SObject obj;
        obj = new Account(Name='Poojan', Phone='9876076');
        Account acc1 = (Account)obj;
        System.debug(acc1);
        obj = new Account(Name='Smit' , Phone='45768754');
        Account acc2 = (Account)obj;
        System.debug(acc2);
        // Student__c student = new Student__c(Name='Dhiraj');
        // System.debug(student);
        
    }
}