global class FirstBatchLead implements Database.Batchable<sObject>
{   
    //Start method of Batch Class    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {        
		String query = 'SELECT Id, Name, Phone FROM Account'; //query only those accounts on the logic will execute
        return Database.getQueryLocator(query);
    }
    
    //Create 100 Lead Records in Execute method     
    global void execute(Database.BatchableContext BC, List<Account> accList)
    {        
        for(integer i = 1; i < 10; i ++)
        {         
            Account accVar = new Account(); //create a new account record            
            accVar.Name = 'Test' +i; 
            accVar.Phone = '112233';
            accList.add(accVar);
        }          
        
        insert accList; //inserting accounts and add the accountVariable
    }

        //Call another class and update those 100 records
        global void finish(Database.BatchableContext BC)
        {
            SecondBatchLead secObj = new SecondBatchLead();
            Id batchId = Database.executeBatch(secObj, 1);
            System.debug('SecondBatchLead Class Called');
        } 
     
}