public class OpportunityService {
    public static void updateDesription(List<Opportunity> newList){
        for(Opportunity opp: newList){
            opp.description = 'Created New';
        }
    }
    public static void afterInsertMethod(Map<Id , Opportunity> newMap){
        System.debug(newMap);
    }
}