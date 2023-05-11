trigger CreateContactsOnAccountCreation on Account (after insert , after update) {

     if(Trigger.isInsert && Trigger.isAfter){
        CreateContactsOnAccountCreationHandler.createContactsOnAccountCreate(Trigger.new);
    }
    else if(Trigger.isUpdate && Trigger.isAfter){
         CreateContactsOnAccountCreationHandler.createContactsOnAccountUpdate(Trigger.new , Trigger.old);
         }
         
}