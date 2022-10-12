//demo creating 100 Account Records with Name, Phone, Site, BillingState
public class AccountHunderedBatch implements Database.Batchable<sObject>
{
    //declare a integer recordCount variable for storing the Account Record Size    
    public AccountHunderedBatch()
   {
      System.debug('AccountHunderedBatch Constructor Called');
   }
	//start method for querying records for creation of Name
   public Database.QueryLocator start(Database.BatchableContext BC)
   {
      String query = 'SELECT Id, Name, Phone, Site FROM Account'; //As we are creating Account Record with Name only
       return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext BC, List<Account> accList)
   {
       //adding account records with full details
       Account accRec = new Account();
       for(Integer i = 0; i < 100; i++)
       {
           accRec.Name = 'Test Account'+ ' '+i; //TestAccount 1, TestAccount 2
           accRec.Phone = '12345';
           accRec.Site = 'Account Site'+ ' '+i; //Account Site 1, Account Site 2
           accRec.BillingState = 'Rajasthan'+ ' '+i;
           accList.add(accRec);           
       }
       
       insert accList; 
   }

   public void finish(Database.BatchableContext BC)
   {
       
   }
}