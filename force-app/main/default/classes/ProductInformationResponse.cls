global class ProductInformationResponse {
    /*
    Purpose			: This is a class that is used as a response model for ProductInformationApi.
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    public List<ProductInformation> productInformations{get;set;}
    public Contact contact {get;set;}
}