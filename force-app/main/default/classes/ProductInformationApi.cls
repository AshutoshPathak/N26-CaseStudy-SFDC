@RestResource(urlMapping='/ProductInformationApi')
global with sharing class ProductInformationApi {
    /*
    Purpose			: This class serves the purpose of being a Salesforce API to enternal endpoints through which they can extract Product information
    				  using the unique identifiers of Contacts.
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    static LoggingUtils logger = new LoggingUtils('ProductInformationApi');
    @Httpget
    global static ProductInformationResponse getProductInfo(){
        ProductInformationResponse resp = new ProductInformationResponse();
        String contactId = RestContext.request.params.get('contactid');
        system.debug('##contactId: '+contactId);
        //If there is nothing in Unique Identifiers Ids of contact, dont process anything and return nothing
        if(String.isBlank(contactId))
            return resp;
        try{
            Contact con = ContactsSelector.getRecordByUniqueIdentifier(contactId);
            if(con == null){
                return resp;
            }
            List<Product_Information__c> prodInfos = ProductInformationSelector.getRecordsByCountryAndProduct(con.Home_Country__c, con.Product__c);
            List<ProductInformation> prodInfoModels = new ProductInformation().getProductInfoModel(prodInfos);
            resp.contact = con;
            resp.productInformations = prodInfoModels;
        }catch(Exception ex){
            logger.logException(ex, null, true);
            throw new ContactsApiException('Exception raised in ProductInformationApi. Error Message: '+ex.getMessage());
        }
        return resp;
    }
    
    public class ContactsApiException extends Exception{}

}