public class FetchChildRecord {
    public static void newMethod(){
        List<contact> newContact = new List<Contact>();
		List<String> AccountName = new List<String>();
        
    /*   // Parent to child query
      for (Account a : [SELECT Id, Name, (SELECT LastName FROM Contacts)
                  FROM Account
                  WHERE Name = 'Edge Communications']) {
     	 	newContact.addAll(a.contacts);
		}
         system.debug(newContact);*/
        
        //Child to parent query
        
     
    }
}