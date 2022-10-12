public class CTPersonTriggerController
{    
    public void beforeInsert(List<Person__c> personList)
    {
        for(Person__c personVar: personList) //iterate over the existing record list
        {
            personVar.Health_Status__c = 'Green';
        }
    }
    
    public void generateToken(List<Person__c> personList1)
    {
        for(Person__c perVar: personList1)
        {
            perVar.Token__c = CTPersonController.getToken(perVar.Mobile__c);
        }
    }
    
    public void afterInsert(List<Person__c> personList)
    {
		System.debug('After Insert Method Called');
    }
}