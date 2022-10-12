public class SecondBatch implements Database.Batchable <SObject>
{
	public Database.QueryLocator start(Database.BatchableContext bc)
    {
        //query those records whose fields we want to update
        String query = 'SELECT Id, Phone FROM Account WHERE Name LIKE "Test%" ';
        return Database.getQueryLocator(query);
    }
     
    public void execute(Database.BatchableContext bc, List<Account> accList1)
    {
        for(Account accVar: accList1)
        {			 
            accVar.Phone = '11223344';
        }        
        update accList1;
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Successfully Updated Account Record');
    }
}