public class CreateAccountClass
{
	public void Account()
    {
        List<Account> listNew = new List<Account>();
        
        
        for(Integer i = 0; i < 100; i++)
        {
            Account accNew = new Account();
            accNew.Name = 'CreateAccountClass' +i;
            accNew.Phone = '00000';
            accNew.Rating = 'Hot';
            listNew.add(accNew);
        }        
        upsert listNew;
    }
}