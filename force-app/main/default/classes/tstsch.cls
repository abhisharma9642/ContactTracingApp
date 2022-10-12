global class tstsch implements Schedulable{
    global void execute(schedulableContext sc) {
        SecondBatch classObj = new SecondBatch();
        Database.executeBatch(classObj);
    }
}