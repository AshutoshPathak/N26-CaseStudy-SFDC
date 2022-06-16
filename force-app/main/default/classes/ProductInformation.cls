global class ProductInformation {
    /*
Purpose			: This is a Model to contain the Product_Information__c records in a model way to provide a encapsulation on main object record.
Author			: Ashutosh Pathak
Created Date	: 15 June 2021
Created For		: N26 Case Study
Version			: 1: Initial Draft 
*/
    @AuraEnabled
    public String productTypeCategory{get;set;}
    @AuraEnabled
    public String productName{get;set;}
    @AuraEnabled
    public String productId{get;set;}
    @AuraEnabled
    public String countryName{get;set;}
    @AuraEnabled
    public String currencyISOCode{get;set;}
    @AuraEnabled
    public decimal amount{get;set;}
    @AuraEnabled
    public decimal percentage{get;set;}
    @AuraEnabled
    public String productValueWhenAmountPercentageIsNull{get;set;}
    @AuraEnabled
    public Boolean isAmount{get{return amount != null;}}
    @AuraEnabled
    public Boolean isPercentage{get{return percentage != null;}}
    
    public ProductInformation(){}
    public List<ProductInformation> getProductInfoModel(List<Product_Information__c> prodInfos){
        List<ProductInformation> result = new List<ProductInformation>();
        if(prodInfos == null || prodInfos.isEmpty())
            return result;
        for(Product_Information__c prodInfo: prodInfos){
            ProductInformation obj = new ProductInformation();
            obj.amount = prodInfo.Amount__c;
            obj.percentage = prodInfo.Percentage__c;
            obj.countryName = prodInfo.Country__r.Name;
            obj.currencyISOCode = prodInfo.CurrencyISOCode;
            obj.productId = prodInfo.Product__c;
            obj.productName = prodInfo.Product__r.Name;
            obj.productTypeCategory = prodInfo.RecordType.Name;
            obj.productValueWhenAmountPercentageIsNull = prodInfo.Replacement_Text__c;
            result.add(obj);
        }
        return result;
    }
}