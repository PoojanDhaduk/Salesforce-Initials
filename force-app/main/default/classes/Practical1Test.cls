@isTest
public class Practical1Test {
	@isTest
    private static void testMethodClass(){
        List<String> nameList = new List<String>{'Poojan' , 'Smit' , 'Prince'};
        List<String> nameList0 = new List<String>();


        Practical1.createAccountAndContact('Surat Bank' , nameList);
        Practical1.createAccountAndContact('' ,nameList0 );
    }
    
}