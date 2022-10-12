public with sharing class ApexTriggerHandler 
{
    public ApexTriggerHandler() 
    {
        System.debug('ApexTriggerHandler constructor');
    }
    public string triggerMethod()
     {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        return 'Hello';
    }
}