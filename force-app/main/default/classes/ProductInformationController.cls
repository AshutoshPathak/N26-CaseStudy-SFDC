public with sharing class ProductInformationController {
    /*
        Purpose			: This is a class that is acting as a controller for LWC to show Product Informations on Case Layout
        Author			: Ashutosh Pathak
        Created Date	: 17 June 2021
        Created For		: N26 Case Study
        Version			: 1: Initial Draft 
    */
    static LoggingUtils logger = new LoggingUtils('ProductInformationController');
    @AuraEnabled(cacheable = true)
    public static ProductInformationModel fetchRecords(String caseRecordId){
        logger.log(LoggingUtils.LogType.DEBUG, 'Method: fetchRecords :: caseRecordId: '+caseRecordId , null, false);
        Case cs = CaseSelector.getRecordById(caseRecordId);
        if(cs == null){
            return null;
        }
        ProductInformationModel result = new ProductInformationModel();
        List<Product_Information__c> productInfos = ProductInformationSelector.getRecordsByCountryAndProduct(cs.Contact.Home_Country__c, cs.Contact.Product__c);
        List<ProductInformation> prodInfos = new ProductInformation().getProductInfoModel(productInfos);
        result.ProductInformations = prodInfos;
        result.ContactName = cs.Contact.Name;
        result.ContactId = cs.ContactId;
        result.ContactPhone = cs.Contact.Phone;
        result.ContactEmail = cs.Contact.Email;
        if(!prodInfos.isEmpty()){
            result.ProductName = cs.Contact.Product__c;
            result.ProductId = prodInfos[0].productId;
        }
        	
        logger.log(LoggingUtils.LogType.DEBUG, 'Method: fetchRecords :: result: '+result , null, false);
        return result;
    }
    
    public class ProductInformationModel{
        @AuraEnabled
        public List<ProductInformation> ProductInformations{get;set;}
        @AuraEnabled
        public string ProductName{get;set;}
        @AuraEnabled
        public string ProductId{get;set;}
        @AuraEnabled
        public string ContactName{get;set;}
        @AuraEnabled
        public string ContactPhone{get;set;}
        @AuraEnabled
        public string ContactEmail{get;set;}
        @AuraEnabled
        public string ContactId{get;set;}
    }   
}