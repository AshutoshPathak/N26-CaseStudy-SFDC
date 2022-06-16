public class LoggingUtils {
	/*
    Purpose			: This is a logging utility to serve the purpose of debugging info/warning/errors.
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    private String className;
    public LoggingUtils(String className){
        this.className = className;
    }
    
    public void log(LogType logType, String message, String extraLongMessage, Boolean isObjectLoggingNeeded){
        system.debug(logType + ' Class : '+className+'. Message - ' +message);
        logToObject(message, logType, extraLongMessage, isObjectLoggingNeeded);
    }
    
    public void logException(Exception ex, String extraLongMessage, Boolean isObjectLoggingNeeded){
        String message = ex.getMessage();
        system.debug(LogType.ERROR + ' Class : '+className+'. '+message);
        if(String.isBlank(extraLongMessage))
            extraLongMessage = 'Message - '+ message+'. Stack Trace: '+ex.getStackTraceString();
        logToObject(message, LogType.ERROR, extraLongMessage, isObjectLoggingNeeded);
    }
    
    private void logToObject(String message, LogType logType, String extraLongMessage, Boolean isObjectLoggingNeeded){
        if(isObjectLoggingNeeded){
            Log__c obj = getLogObject(message, logType, extraLongMessage);
            DMLHelper.saveRecords(Constants.Log.ObjectName, new List<Log__c>{obj}, DMLHelper.ValidationType.DoInsert);
        }
    }
    
    public Log__c getLogObject(String message, LogType logType, String extraMessage){
        Log__c log = new Log__c(Message__c = message, Type__c = String.valueOf(logType), Extra_Message_Details__c = extraMessage, Class__c = className);
        return log;
    }
    
    public enum LogType{
        DEBUG, WARNING, ERROR, INFO
    }
}