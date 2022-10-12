public with sharing class CTPersonController 
{
    public CTPersonController()
    {
        System.debug('CTPersonController Constructor Called');
    }
    public static string getToken(String mobileNo)
      {
        Blob value = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', value);// hash(value)-Blob(value)-mobileNo-String(mobileNo)
        return EncodingUtil.base64Encode(hash); //convert blob value to string by using EncodingUtil Class
      }
    
    public static List<Person__c> getRecentHealthChanges() //in order to return Records, write List of Object Name as a Return Type
    {
		//Querying all Records from All Fields from Person__c with LIMIT 100 with ORDER BY DESC
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
                FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS Last LIMIT 100];        
    }
    
    public static List<Person__C> searchPeople(String searchTerm)
    {
        //Querying all records from all fields from Person__c where either Name, MobileNo and Token matches the searchTerm with ORDER BY DESC
        //and pass the list as return type to method
        searchTerm = searchTerm + '%'; 
        return [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c 
                FROM Person__c
                WHERE Name LIKE :searchTerm 
                OR Mobile__c LIKE :searchTerm 
                OR Token__c LIKE :searchTerm 
                ORDER BY Status_Update_Date__c DESC 
                NULLS Last]; 
    }
    
    public static Person__c getPersonById(String personId)
    {
        //Querying all records from all fields where Id matches the personId and pass the list as return type of method getPersonById
        List<Person__C> peopleList = [SELECT Id, Name, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c
                                      FROM Person__c 
                                      WHERE Id =: personId]; //where Id matches the personId
        if(peopleList != NULL && peopleList.size() > 0) //list is not null(list has some space) as well as list has some records
        {
            return peopleList[0];
        }
        return null;
    }
    
    public static Map<String, Integer> getHealthStatusCount()
    {
        Map<String, Integer> healthCountMap = new Map<String, Integer>();
        //always use AggregateResult ar to 
        for(AggregateResult ar: [SELECT Health_Status__c, COUNT(Id) total 
                                 FROM Person__c 
                                 GROUP By Health_Status__c])
        {   
            String healthStatus = String.valueOf(ar.get('Health_Status__c'));
            Integer count = Integer.valueOf(ar.get('total'));
            healthCountMap.put(healthStatus, count);
        } 
        return healthCountMap;
    }
}