# N26 Product Informations Case Study

This guide talks about the case study of N26 Salesforce. Below are the main componets:

### Objects:
1) Case : To show the Product Information on Case record page
2) Contact : To contain Home Country and Product Name
3) Log__c : To keep track of issues or logs setup inside the code
4) Product_Information__c : To contain the product information mapping
5) Product2 : Standard Salesforce functionality for products
6) Country : To create a separation of Countries along with the currecny offered


### A walkthrough of Complete process:

1) The process starts with creating the products:
<img width="860" alt="image" src="https://user-images.githubusercontent.com/271199/174050941-3f08ee49-4e00-461c-a482-648aa2e59f54.png">
A sample product looks like this:
<img width="860" alt="image" src="https://user-images.githubusercontent.com/271199/174051097-4f778a11-8ec5-4f23-bd2d-058a7b8af142.png">
2) Create Country records and make sure appropriate currency is added
<img width="860" alt="image" src="https://user-images.githubusercontent.com/271199/174051318-9ef95a5e-d05a-45b1-b84a-a03f5433efa9.png">
3) Create Product Information records for each record type. Example of record types are: Cost Per Calendar Month, ATM Fee in Other Currencies and Card Replacement Cost
<img width="1141" alt="image" src="https://user-images.githubusercontent.com/271199/174051914-ecced2dc-169b-495e-8f88-cadf7d28dd9f.png">
4) Once all the records are created, create a case record. Contact attached with Case must have Home Country and Product fields populated. Once the Case is created, open it, navigate to the Product tab and see the Product Categories said contact has (as per the ask of Case Study):
<img width="944" alt="image" src="https://user-images.githubusercontent.com/271199/174052614-71612b56-ba99-429d-a3c6-14145cafd93d.png">
5) There is one API is created to return the Product Information records based on the contact unique identifier passed. Below is the sample screenshot of api callout:
<img width="1137" alt="image" src="https://user-images.githubusercontent.com/271199/174053358-edc5935e-12a7-4a11-95cc-c9c2d43d85bb.png">



### Pre Deployment Steps:

1) Multi Currency needs to be enabled in the org and we need to select 2 currencies viz GBP, EUR in manage currecnies. For more information on setting up these things,please refer: https://help.salesforce.com/s/articleView?id=sf.admin_currency.htm&type=5


### Post Deployment Steps:
1) Please open the anonymous window and execute below command to create all the sample test records:

DataFactory.createSampleRecords();

## Observations
### Enhancements: 

1) Main functionalities updates viz, Country, Product Information etc are monitored via Field History Tracking. This will help keeping track of who did what in terms of modifications. For helping with any regulations/audit, this thing can be benifical to N26 bank.

<img width="1180" alt="image" src="https://user-images.githubusercontent.com/271199/174054884-1f27b1fb-e591-4ebe-964e-4528e87a6cb0.png">

2) Selector patterns are used in the code to keep all the DB queries at one place (per object) for better maintenance of code and Object Responsibility principle of OOPS.
3) A custom logging framework is used with the help of Log__c object to keep track of error/info/warning/debug throughout the application.
4) Code is written using seperation of concern and based on modularity so that its easy to manage and work
5) DataFactory class is written that serves multiple purposes. This class can be used as a Test Data Factory from Unit Test and can be used outside tests to create sample data. But at the same side this class make sure that even by mistake it is not creating records if current org is production.
6) Written DML Helper class to validate the Object permissions whenever a DML is happening. This safeguards the code behavior to not run the code if current user doesnt have such privileges as per their profile permissions. This also helps passing security scan reviews of Salesforce. All the Selector patterns queries are also running with "WITH SECURITY_ENFORCED" so that FLS are respected.


### Scope of Improvement:
1) Transaction Security Policies can be implemented to ensure which user is logging in and performing what activities for better monitoring of the bank's Salesforce ecosystem.
2) A Dashboard on frequent updates and top Product categories can be built so that users of systems can get much benifit out of it and can see most of the information at home page.
3) The connected app that is created to provide external users access to the ProductInformationAPI needs to be mapped with Integration User with API only and very minimal permissions. 
