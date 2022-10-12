global class MiscClass implements Database.Batchable<SObject>
{
	global integer recordCount = 0;
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id, Name, Phone FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accountList)
    {                
        
        for(Integer i = 0; i < 100; i++)
        {
            Account accNew = new Account();
            accNew.Name = 'MiscClass'+ ' '+i;
            accNew.Phone = '00000';
            //accNew.Active__c = 'True';  
            accountList.add(accNew);
        }
        
        insert accountList;
    }
    
    global void finish(Database.BatchableContext BC)
    {
        System.debug('All the Account Records Processed');
    }
}