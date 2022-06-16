@isTest
public class ProductInformationApiTest {
    /*
    Purpose			: This is a Test class to verfiy the functionalities of ProductInformationApi
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
	@testSetup
    static void init(){
        DataFactory.createSampleRecords();
    }
    @isTest
    static void testResponse(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInformationApi';
        req.httpMethod = 'GET';
        req.addParameter('contactid', 'c88f0c46-eaf9-11ec-8fea-0242ac120002');
        RestContext.request = req;
        RestContext.response= res;
        Test.startTest();
        ProductInformationResponse response = ProductInformationApi.getProductInfo();
        Test.stopTest(); 
        System.assertEquals(true, !response.productInformations.isEmpty());
    }
    
    @isTest
    static void testResponseNegative(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/ProductInformationApi';
        req.httpMethod = 'GET';
        req.addParameter('contactid', 'c88f0c46-eaf9-11ec-8fea-WRONGPARAM');
        RestContext.request = req;
        RestContext.response= res;
        Test.startTest();
        ProductInformationResponse response = ProductInformationApi.getProductInfo();
        Test.stopTest(); 
        System.assertEquals(true, response.productInformations == null || response.productInformations.isEmpty());
    }
}