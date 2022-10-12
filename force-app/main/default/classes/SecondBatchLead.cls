public class SecondBatchLead implements Database.Batchable <SObject>
{
	public Database.QueryLocator start(Database.BatchableContext bc)
    {
        //query those records whose fields we want to update
        String query = 'SELECT Id, Phone FROM Account';
        return Database.getQueryLocator(query);
    }
     
    public void execute(Database.BatchableContext bc, List<Account> accList1)
    {
        for(Account accVar: accList1)
        {
			accVar.Name = 'Web'; 
            accVar.Phone = '11223344';
        }        
        update accList1;
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Successfully Updated Account Record');
    }
}