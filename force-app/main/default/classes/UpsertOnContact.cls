public class UpsertOnContact {
        public static void upsertonContacts(){
            List<apex_customer__c> custList = new List<apex_customer__c>();
    for (Integer i = 0; i < 10; i++) {
       apex_customer__c objcust=new apex_customer__c(Name = 'Test' +2,
       apex_external_id__c='1112');
            upsert objcust apex_external_id__c;
      custList.add(objcust);
  		}
            upsert custList apex_external_id__c;
   	 }
 }