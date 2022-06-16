public class ProductInformationSelector {
    /*
    Purpose			: This is a class following the selector pattern so that all the DB retrieval queries can be stored here for Product_Information__c object.
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    static LoggingUtils logger = new LoggingUtils('ProductInformationSelector');
    
    public static String fields = 'Country__c, Country__r.Name, Product__c, Product__r.Name, Replacement_Text__c, Amount__c, Percentage__c, CurrencyIsoCode, RecordTypeId, RecordType.Name, Id';
    public static List<Product_Information__c> getRecordsByCountryAndProduct(String country, String productName){
        String query = generateSelectClause() + ' WHERE Country__r.Name=:country AND Product__r.Name=:productName WITH SECURITY_ENFORCED';
        logger.log(LoggingUtils.LogType.DEBUG, query, null, false);
        List<Product_Information__c> result = (List<Product_Information__c>)Database.query(query);
        return result;
    }
    
    private static String generateSelectClause(){
        return 'SELECT '+fields+' FROM '+Constants.ProductInformation.ObjectName;
    }
}