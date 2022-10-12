global class MyBatch implements Database.Batchable<SObject>
{    
    public integer recordCount = 0;
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id, Name, Phone, BillingState FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accountList) //creating accountList and pass the accountList to the method
    {
        List<Account> accList = new List<Account>();
        
        for(Integer i = 0; i < 100; i++)
        {
            Account accRec = new Account(); //create a blank accout record and allocate the memory to it.
            accRec.Name = 'Test Account'+ ' '+i; //Test Account 1
            accRec.Phone = '00000';
			accRec.BillingState = 'My State'+ ' '+i; // My State 1         
            accList.add(accRec);
        }
        
        insert accList;                        
        
        Integer countList = [SELECT Count() FROM Account WHERE Name LIKE 'Test%'];
        System.debug(countList);
    }
    
    global void finish(Database.BatchableContext BC)
    {
        System.debug('Finish method get Called');
    }        
}