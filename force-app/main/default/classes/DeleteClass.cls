public class DeleteClass {
    public static void deleteMethod(){
        List<Account> accToDelete = [select Name FROM Account 
                                     WHERE createdDate = N_DAYS_AGO:0 OR createdDate = N_DAYS_AGO:1  ];
      List<Account> deletedAccounts = [SELECT Name , createdDate FROM Account WHERE IsDeleted = true ALL ROWS];

            System.debug(accToDelete);
         delete accToDelete;
        undelete deletedAccounts;
    }
}