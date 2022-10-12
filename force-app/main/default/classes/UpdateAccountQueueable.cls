public class UpdateAccountQueueable implements Queueable
{
    private List<Account> accList;
    private Id parentAccId;
    
    public UpdateAccountQueueable(List<Account> accRecords, Id id)
    {
        this.accList = accRecords;
        this.parentAccId = id;
    }
    
    public void execute(QueueableContext context)
    {
        for(Account accVar: accList)
        {
            accVar.ParentId = parentAccId;
        }
        
        update accList;
    }
}