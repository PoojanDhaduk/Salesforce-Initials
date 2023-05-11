public class UpdateClass {
    public void insertOp(){
        List<Account> accList = [SELECT id, Name, Active__c 
   FROM Account WHERE Active__c='Yes'];
	//System.debug(accList);
	List<Account> updatedAccountList = new List<Account>();
        for(Account acc : accList){
            acc.Website = 'www.getoncrm.com';
             updatedAccountList.add(acc);
        }
        update updatedAccountList;
        System.debug(updatedAccountList);
      
    }
}