public class DatabaseRollback {
    public static void newMethod(){
        Account a = new Account(Name = 'xxx'); insert a;
        String AccountNum1 = [SELECT AccountNumber FROM Account WHERE Id = :a.Id].AccountNumber;
        System.debug(AccountNum1);
        
        // Create a savepoint while AccountNumber is null
        Savepoint sp = Database.setSavepoint();
        
        // Change the account number
        a.AccountNumber = '123';
        update a;
        AccountNum1 = [SELECT AccountNumber FROM Account WHERE Id = :a.Id].AccountNumber;
        System.debug(AccountNum1);
        
        // Rollback to the previous null value
        Database.rollback(sp);
        AccountNum1 = [SELECT AccountNumber FROM Account WHERE Id = :a.Id].AccountNumber;
        System.debug(AccountNum1);
    }
}