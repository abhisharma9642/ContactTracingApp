@isTest
public class AccountBatchClassTest 
{
	@isTest
    private static void batchTestClass()
    {
     	List<Account> accList = new List<Account>();
        
        for(integer i = 0; i < 5; i++)
        {
         	accList.add(new Account(Name = 'TestAccount' +i));
        }
       insert accList;
        
        Test.startTest();
            AccountBatchClass testObj = new AccountBatchClass();
            Id batchId = Database.executeBatch(testOBj, 5);
        
        Test.stopTest();
            List<Account> newList = [SELECT Id, Name FROM Account WHERE Name like 'TestAccount%'];
        	System.assertEquals(5, newList.size());                    
    }
}