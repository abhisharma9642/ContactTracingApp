trigger CTPersonTrigger on Person__c (before insert, before update, before delete, after insert, after update, after delete, after undelete)
{
	CTPersonTriggerController personObj = new CTPersonTriggerController();
    
    if(trigger.isBefore && trigger.isInsert)
    {
        personObj.beforeInsert(trigger.new);
        personObj.generateToken(trigger.new);
    }
}