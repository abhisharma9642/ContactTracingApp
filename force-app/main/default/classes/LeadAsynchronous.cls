public class LeadAsynchronous 
{
    @future
    public static void updateLeadRecords(Set<Id> setLead)
    {      
        List<Lead> listLead = [SELECT Id, Name, LeadSource FROM Lead WHERE Id IN : setLead];
        for(Lead leadVar: listLead)
        {
         	leadVar.Company = 'Lead List';
            leadVar.LeadSource = 'Web';
        }
        update listLead;
        
        //createLeadAsynchronous();
    }
    
    @future
    public static void createLeadAsynchronous()
    {
        Lead leadRecord = new Lead(LastName = 'LeadList', Company = 'Lead List Inc');                                
        insert leadRecord;
    }
}