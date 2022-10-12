public with sharing class CTLocationController
{
	public CTLocationController()
    {
        System.debug('CTLocationController Constructor Called');
    }
     //as return type is list, thats why we return the list
    public static List<Location__C> getRecentStatusChanges()
    {
        //Querying all records from all fields ORDER BY statusUpdateDate field limit 100
        List<Location__C> locList = [SELECT Id, Name, Status__c, Status_Update_Date__c, Red_Score__c, Pincode__c, Address__c 
                                     FROM Location__c 
                                     ORDER BY Status_Update_Date__c DESC
                                     NULLS Last
                                     LIMIT 100];
        return locList;
    }
    
    public static List<Location__c> searchLocations(String searchTerm)
    {
		searchTerm = searchTerm + '%';
        //Querying all records from all fields name, pincode, address like searchTerm
        Set<Id> setPersonId = new Set<Id>();
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c 
            FROM Location__c  // as return type is list that's why we return list
            WHERE Name LIKE 'searchTerm%' 
            OR Pincode__c LIKE 'searchTerm%' 
            OR Address__c LIKE 'searchTerm%' 
            ORDER By Status_Update_Date__c NULLS Last];
    }
    
    public static Location__c getLocationById(String locationId) 
    {        
        //Querying all records from all fields where id matches the locationId
        List<Location__c> locationList = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, Status_Update_Date__c 
         FROM Location__c 
         WHERE Id =: locationId];
         //check is list is not NULL and Size of List should be greater than zero.
             if(locationList != NULL && locationList.size() > 0 ) 
             {
                 return locationList[0];
             }
        return NULL;
    }
    
    public static Map<String, Integer> getStatusCount()
    {
        Map<String, Integer> healthCountMap = new Map<String, Integer>();
        for(AggregateResult ar:[SELECT Status__c, COUNT(id) total FROM Location__c GROUP BY Status__c])
        {
       //     String healthStatus = String.valueOf(ar.get('Status__c'));
       //     Integer count = Integer.valueOf(ar.get('total'));
            healthCountMap.put(String.valueOf(ar.get('Status__c')), Integer.valueOf(ar.get('total')));
            System.debug(healthCountMap);
        }
        return healthCountMap;
    }
}