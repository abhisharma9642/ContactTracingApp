public class AccountCreation
{	    
    public void accCreate()
    {
        List<Account> accList = new List<Account>();
        for(integer i = 0; i < 5; i++)
        {
            Account acc = new Account();
            acc.Name = 'TestAccount' +i;
            acc.Phone = '11223344';            
            accList.add(acc);
        }        
        insert accList;
    }
}