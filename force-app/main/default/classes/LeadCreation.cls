public class LeadCreation 
{
    public void leadCreate()
    {
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 0; i < 10; i++)
        {
            Lead var = new Lead();
				            
            var.FirstName = 'Test';
            var.LastName = 'Lead' + i;
            var.Company = 'SALESFORCE INC';
            var.LeadSource = 'Web';
            var.Status = 'Closed - Converted';
            
            leadList.add(var);
        }
        
        insert leadList;
    }
}