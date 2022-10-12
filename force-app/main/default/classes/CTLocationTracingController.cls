public class CTLocationTracingController
{
	//CTLocationTracingController Constructor Called
    public CTLocationTracingController()
    {
        System.debug('CTLocationTracingController Constructor Called');
    }
    
    public static List<Location_Tracing__c> getVisitors(String locationId)
    {
        //Querying all records from all fields and related fields by finding Id using locationId and ORDER By Visit_Date__c DESC
        return [SELECT Id, Name, Person__c, Location__c, Visit_Date__c, Person__r.Token__c, Person__r.Health_Status__c
                FROM Location_Tracing__c 
                WHERE Id =: locationId
                ORDER BY Visit_Date__c DESC ];
    }        
    
    public static List<Location_Tracing__c> getLocationsByPersonIds(Set<Id> personIds)
    {	
        //Querying all records from all fields where id matches with Set of personIds and visit date is last 10 days
        return [SELECT Id, Name, Person__c, Location__c
        	FROM Location_Tracing__c
        	WHERE Person__c IN :personIds
        	AND Visit_Date__c = LAST_N_DAYS:10];
    }
    
    public static Location_Tracing__c getLocationsByLocationId(Set<Id> locationIds)
    {
		//Querying all records from all fields where id 
        return [SELECT Id, Name, Person__c, Location__c
               FROM Location_Tracing__c
               WHERE Location__c IN :locationIds
               AND Person__r.Health_Status__c = 'Green'
               AND Visit_Date__c = LAST_N_DAYS:10];
    }
    
    public static List<Location_Tracing__c> checkDuplicates(List<Location_Tracing__c> newLocationTraces)
    {
        //iteration on newLocationTraces and store the unique locationIds and personIds
        //creating new set for locationIds
        Set<Id> locationIdSet = new Set<Id>();
        //creating new set for locationIds
        Set<Id> personIdSet = new Set<Id>();        
        for(Location_Tracing__c traceVar: newLocationTraces)
        {
            //adding location__c record to locationIdSet
            locationIdSet.add(traceVar.Location__c);
            personIdSet.add(traceVar.Person__c);
        }
        
        //map for locationIds and personIds
        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        //querying existing Records based on locationId and personId
        //Creating a List of Duplicate Records
        List<Location_Tracing__C> duplicateList = new List<Location_Tracing__c>();
        
        //Query existing records and compare id from Location__c and Person__c using locationIdSet and personIdSet
        List<Location_Tracing__c> existingRecords = [SELECT Id, Person__c,
                                                    Location__c FROM
                                                    Location_Tracing__c
                                                    WHERE Location__c IN:locationIdSet
                                                    AND Person__c IN: personIdSet];
        //checking list is !Null as well as Size > 0
        if(existingRecords != null && existingRecords.size() > 0)
        {
            for(Location_Tracing__c traceVar1: existingRecords) //iterate over existingRecords
            {
               if(! mapOfExistingRecords.containsKey(traceVar1.Location__C)) //check is existingMap containsKey with Location__c(Id)
               {
                   mapOfExistingRecords.put(traceVar1.Location__c, new Set<Id>()); //if Location__c is not Null and add them in new Set
               }
                //get Location__c using get and add them in set of Person__c
                mapOfExistingRecords.get(traceVar1.Location__c).add(traceVar1.Person__c);
            }
            //iterate over the newLocationTraces
           for(Location_Tracing__c trace: newLocationTraces)
           {
               //first check the locationId
               //if item found in map, then check the personIds check the locationId as well as personIds to check the locationId
               if(mapOfExistingRecords.containsKey(trace.Location__c)
                 && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__C))
               {
                   duplicateList.add(trace);
               }
           }
        }
        return duplicateList;
    }
}