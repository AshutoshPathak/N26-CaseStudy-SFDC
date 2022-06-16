@isTest
public class ProductInformationControllerTest {
	/*
    Purpose			: This is a Test class to verfiy the functionalities of ProductInformationApi
    Author			: Ashutosh Pathak
    Created Date	: 17 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
	@testSetup
    static void init(){
        DataFactory.createSampleRecords();
    }
    @isTest
    static void testResponse(){
        Case obj = [SELECT Id FROM Case LIMIT 1];
        ProductInformationController.ProductInformationModel result = ProductInformationController.fetchRecords(obj.Id);
        system.assert(result != null && !result.ProductInformations.isEmpty());
    }
}