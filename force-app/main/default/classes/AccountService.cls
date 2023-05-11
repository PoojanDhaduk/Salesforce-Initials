public with sharing class AccountService {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccounts(String strAccountName) {
      System.debug(strAccountName);
      String strKey = '%'+strAccountName+'%';
       List<Account> accList = [SELECT Id,Name, AnnualRevenue ,AccountNumber FROM Account WHERE name like :strKey  WITH SECURITY_ENFORCED ];
       System.debug(accList);
       return accList;
     }
}