public with sharing class CheckProfileNameandCountry {
    public static void restrictUser(List<Account> newList){

        Id profileId = UserInfo.getProfileId();
        Profile currentUserProfile = [SELECT Id, Name FROM Profile WHERE Id = :profileId WITH SECURITY_ENFORCED];
        Id userId = UserInfo.getUserId();
        user currentUser = [SELECT Id , Country FROM User WHERE Id = : userId WITH SECURITY_ENFORCED];
    
       // System.debug(currentUserProfile.Name);
        //System.debug(currentUser.Country);    

        for(Account acc : newList){
            if(currentUserProfile.Name == 'Custom: Marketing Profile' && currentUser.Country == 'US'){     
                acc.addError('You are not allowed to modify Account records');
            }
        }
    }
}