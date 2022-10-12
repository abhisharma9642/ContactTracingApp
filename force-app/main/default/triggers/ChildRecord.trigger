trigger ChildRecord on Account (before insert, after insert, before update, after update) 
{
	ChildRecordController obj = new ChildRecordController();
    obj.checkChildRecord();
}