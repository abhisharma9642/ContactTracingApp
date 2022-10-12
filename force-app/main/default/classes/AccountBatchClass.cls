//Batch class for account updation and implements database.batchable context
public class AccountBatchClass implements Database.Batchable<SObject>
{
	public  integer recordCount = 0;
    
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {        
        return Database.getQueryLocator([SELECT Id, Name FROM Account]);
    }
    
    
    public void execute(Database.BatchableContext bc, List<Account> accList)
    {
        for(Account accVar: accList)
        {
            accVar.Site = 'www.facebook.com';
        }
        update accList;
        recordCount = recordCount + accList.size();
        System.debug(recordCount);
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Total records processed are' +recordCount);
        //System.debug('Total inserted records are:-' +stringQuery);
        
    }    
}