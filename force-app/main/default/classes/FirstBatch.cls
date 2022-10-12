//BATCH CLASS FOR CREATING ACCOUNT RECORDS

global class FirstBatch implements Database.Batchable<SObject>
{   
    //START METHOD FOR QUERYING ALL THE ACCOUNT RECORDS WHICH ARE TO BE PROCESSED WITH THEIR MANDATORY FIELDS
    global Database.QueryLocator start(Database.BatchableContext BC)
    {        
		String query = 'SELECT Id, Name, Site FROM Account'; //QUERYING ALL THE ACCOUNT RECORDS WITH THEIR MANDATORY FIELDS
        return Database.getQueryLocator(query);
    }
    
    //CREATE 100 ACCOUNT RECORDS
    global void execute(Database.BatchableContext BC, List<Account> accList)
    {        
        //List<Account> accList = new List<Account>();
        Account accRec = new Account(); //CREATE NEW ACCOUNT RECORD
        for(Integer i = 0; i < 100; i++)
        {
            accRec.Name = 'Test Account' +i;
            accRec.Phone = '12345';
            accRec.Site = 'Account Site' +i;

			accList.add(accRec);
        }
        insert accList;
        
        List<Account> soqlQuery = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test%'];
        Integer Countquery = soqlQuery.size();
        System.debug(Countquery);
    }

        //Call another class and update those 100 records
        global void finish(Database.BatchableContext BC)
        {
            System.debug('Countquery finish method Called');
        } 
     
}