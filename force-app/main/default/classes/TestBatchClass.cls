public class TestBatchClass implements Database.Batchable<SObject>
{
	public Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'SELECT Id, LeadSource, Company FROM Lead';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> listLead)        
    {
        for(Lead leadVar: listLead)
        {
            leadVar.LeadSource = 'Other';
            leadVar.Company = 'Salesforce 1';
        }
        
        update listLead;
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Finish Method called in Batch Class');
    }
}