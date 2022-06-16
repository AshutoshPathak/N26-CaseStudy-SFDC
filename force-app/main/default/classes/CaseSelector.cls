public class CaseSelector {
	/*
    Purpose			: This is a class following the selector pattern so that all the DB retrieval queries can be stored here for Case object.
    Author			: Ashutosh Pathak
    Created Date	: 16 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    static LoggingUtils logger = new LoggingUtils('CaseSelector');
    
    public static String fields = 'Contact.Name, Contact.Phone, Contact.Email, Contact.Home_Country__c, Contact.Product__c, Id';
    public static Case getRecordById(Id caseId){
        String query = generateSelectClause() + ' WHERE Id =:caseId';
        logger.log(LoggingUtils.LogType.DEBUG, query, null, false);
        List<Case> results = (List<Case>)Database.query(query);
        Case result = results == null || results.isEmpty() ? null : results[0];
        system.debug('##result: '+result);
        return result;
    }
    
    private static String generateSelectClause(){
        return 'SELECT '+fields+' FROM '+Constants.Cases.ObjectName;
    }
}