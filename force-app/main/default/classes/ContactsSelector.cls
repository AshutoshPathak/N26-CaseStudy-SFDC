public class ContactsSelector {
	/*
    Purpose			: This is a class following the selector pattern so that all the DB retrieval queries can be stored here for Product_Information__c object.
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    static LoggingUtils logger = new LoggingUtils('ContactsSelector');
    
    public static String fields = 'Home_Country__c, Product__c, Name, Unique_Identifier__c, Id';
    public static Contact getRecordByUniqueIdentifier(String uniqueId){
        String query = generateSelectClause() + ' WHERE Unique_Identifier__c =:uniqueId';
        logger.log(LoggingUtils.LogType.DEBUG, query, null, false);
        List<Contact> results = (List<Contact>)Database.query(query);
        Contact result = results == null || results.isEmpty() ? null : results[0];
        system.debug('##result: '+result);
        return result;
    }
    
    private static String generateSelectClause(){
        return 'SELECT '+fields+' FROM '+Constants.Contact.ObjectName;
    }
}