public class TestQueueableClass implements Queueable
{  
	public void execute(QueueableContext context)
    {
        Account newAcc = new Account(Name='Acme');
        insert newAcc;
    }
}