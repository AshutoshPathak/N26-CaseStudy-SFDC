public class DataFactory {
    /*
    Purpose			: This class serves the purpose of being the data factory for some sample records creation via first time or via from test classes
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    public static Product2 createProduct(String productName, Boolean requireInsertToSF){
        Product2 prod = new Product2(Name = productName);
        if(requireInsertToSF){
            DMLHelper.saveRecords('Product2', new List<Product2>{prod}, DMLHelper.ValidationType.DoInsert);
        }
        return prod;
    }
    
    public static Country__c createCountry(String countryName, String currencyIsoCode, Boolean requireInsertToSF){
        Country__c country = new Country__c(Name = countryName, CurrencyIsoCode = currencyIsoCode); //NOPMD
        if(requireInsertToSF){
            DMLHelper.saveRecords('Country__c', new List<Country__c>{country}, DMLHelper.ValidationType.DoInsert);
        }
        return country;
    }
    
    public static Product_Information__c createProductInformation(Id productId, Country__c country, Id recordTypeId, Decimal amount, 
                                                                     Decimal percentage, String replacementText, Boolean requireInsertToSF){ //NOPMD
        Product_Information__c prod = new Product_Information__c(Product__c = productId, Country__c = country.Id, CurrencyISOCode = country.CurrencyIsoCode, RecordTypeId = recordTypeId,
                                                                Amount__c = amount, Percentage__c = percentage, Replacement_Text__c = replacementText
                                                                );
        if(requireInsertToSF){
            DMLHelper.saveRecords('Product_Information__c', new List<Product_Information__c>{prod}, DMLHelper.ValidationType.DoInsert);
        }
        return prod;
    }
    
    public static Account createAccount(String accountName, Boolean requireInsertToSF){
        Account acc = new Account(Name = accountName);
        if(requireInsertToSF){
            DMLHelper.saveRecords('Account', new List<Account>{acc}, DMLHelper.ValidationType.DoInsert);
        }
        return acc;
    }
    
    public static Contact createContact(Id accountId, String lastName, String firstName, String countryName, String productName, String uniqueIdentifier, String email, String phone, Boolean requireInsertToSF){ //NOPMD
        Contact con = new Contact(AccountId = accountId, LastName = lastName, FirstName = firstName, Home_Country__c = countryName, Product__c = productName, Unique_Identifier__c = uniqueIdentifier, Email = email, Phone=phone);
        if(requireInsertToSF){
            DMLHelper.saveRecords('Contact', new List<Contact>{con}, DMLHelper.ValidationType.DoInsert);
        }
        return con;
    }
    
    public static Case createCase(String subject, String status, String origin, Id contactId, Boolean requireInsertToSF){ //NOPMD
        Case cs = new Case(Subject = subject, Status = status, Origin = origin, ContactId = contactId);
        if(requireInsertToSF){
            DMLHelper.saveRecords('Case', new List<Case>{cs}, DMLHelper.ValidationType.DoInsert);
        }
        return cs;
    }
    
    //Not to be used for other than sample records creation
    public static void createSampleRecords(){
        Organization org = [select isSandbox from Organization];
        //Create records either via sandbox or if running from unit test
        if(org.IsSandbox || Test.isRunningTest()){
            //System.Savepoint sp = Database.setSavepoint();
            //Products creation
            Product2 standard = createProduct('Standard', false);
            Product2 black = createProduct('Black', false);
            Product2 metal = createProduct('Metal', false);
            List<Product2> products = new List<Product2>{standard, black, metal};
            DMLHelper.saveRecords('Product2', products, DMLHelper.ValidationType.DoInsert); 
            //Countries records creation
            Country__c de = createCountry('DE', 'EUR', false);
            Country__c fr = createCountry('FR', 'EUR', false);
            Country__c es = createCountry('ES', 'EUR', false);
            Country__c it = createCountry('IT', 'EUR', false);
            Country__c uk = createCountry('UK', 'GBP', false);
            List<Country__c> countries = new List<Country__c>{de, fr, es, it, uk};
            DMLHelper.saveRecords('Country__c', countries, DMLHelper.ValidationType.DoInsert);
            Id cpcmId = Schema.SObjectType.Product_Information__c.getRecordTypeInfosByName().get('Cost Per Calendar Month').getRecordTypeId();
            Id afocId = Schema.SObjectType.Product_Information__c.getRecordTypeInfosByName().get('ATM Fee in Other Currencies').getRecordTypeId();
            Id crcId = Schema.SObjectType.Product_Information__c.getRecordTypeInfosByName().get('Card Replacement Cost').getRecordTypeId();

			//Cost per Calendar Month records creation
            Product_Information__c p1 = createProductInformation(standard.Id, de, cpcmId, 0, null, null, false);
            Product_Information__c p2 = createProductInformation(standard.Id, fr, cpcmId, 0, null, null, false);
            Product_Information__c p3 = createProductInformation(standard.Id, es, cpcmId, 0, null, null, false);
            Product_Information__c p4 = createProductInformation(standard.Id, it, cpcmId, 0, null, null, false);
            Product_Information__c p5 = createProductInformation(standard.Id, uk, cpcmId, 0, null, null, false);
            
            Product_Information__c p6 = createProductInformation(black.Id, de, cpcmId, 9.90, null, null, false);
            Product_Information__c p7 = createProductInformation(black.Id, fr, cpcmId, 9.90, null, null, false);
            Product_Information__c p8 = createProductInformation(black.Id, es, cpcmId, 9.90, null, null, false);
            Product_Information__c p9 = createProductInformation(black.Id, it, cpcmId, 9.90, null, null, false);
            Product_Information__c p10 = createProductInformation(black.Id, uk, cpcmId, null, null, 'N/A', false);
            
            Product_Information__c p11 = createProductInformation(metal.Id, de, cpcmId, 16.90, null, null, false);
            Product_Information__c p12 = createProductInformation(metal.Id, fr, cpcmId, 16.90, null, null, false);
            Product_Information__c p13 = createProductInformation(metal.Id, es, cpcmId, 16.90, null, null, false);
            Product_Information__c p14 = createProductInformation(metal.Id, it, cpcmId, 16.90, null, null, false);
            Product_Information__c p15 = createProductInformation(metal.Id, uk, cpcmId, null, null, 'N/A', false);
            
            //ATM Fee in Other Countries
            Product_Information__c ap1 = createProductInformation(standard.Id, de, afocId, null, 1.7, null, false);
            Product_Information__c ap2 = createProductInformation(standard.Id, fr, afocId, null, 1.7, null, false);
            Product_Information__c ap3 = createProductInformation(standard.Id, es, afocId, null, 1.7, null, false);
            Product_Information__c ap4 = createProductInformation(standard.Id, it, afocId, null, 1.7, null, false);
            Product_Information__c ap5 = createProductInformation(standard.Id, uk, afocId, null, 1.7, null, false);
            
            Product_Information__c ap6 = createProductInformation(black.Id, de, afocId, null, null, 'Free', false);
            Product_Information__c ap7 = createProductInformation(black.Id, fr, afocId, null, null, 'Free', false);
            Product_Information__c ap8 = createProductInformation(black.Id, es, afocId, null, null, 'Free', false);
            Product_Information__c ap9 = createProductInformation(black.Id, it, afocId, null, null, 'Free', false);
            Product_Information__c ap10 = createProductInformation(black.Id, uk, afocId, null, null, 'Free', false);
            
            Product_Information__c ap11 = createProductInformation(metal.Id, de, afocId, null, null, 'Free', false);
            Product_Information__c ap12 = createProductInformation(metal.Id, fr, afocId, null, null, 'Free', false);
            Product_Information__c ap13 = createProductInformation(metal.Id, es, afocId, null, null, 'Free', false);
            Product_Information__c ap14 = createProductInformation(metal.Id, it, afocId, null, null, 'Free', false);
            Product_Information__c ap15 = createProductInformation(metal.Id, uk, afocId, null, null, 'Free', false);
            
            //Card Replacement Cost records creation
            Product_Information__c cp1 = createProductInformation(standard.Id, de, crcId, 6, null, null, false);
            Product_Information__c cp2 = createProductInformation(standard.Id, fr, crcId, 6, null, null, false);
            Product_Information__c cp3 = createProductInformation(standard.Id, es, crcId, 6, null, null, false);
            Product_Information__c cp4 = createProductInformation(standard.Id, it, crcId, 6, null, null, false);
            Product_Information__c cp5 = createProductInformation(standard.Id, uk, crcId, 6, null, null, false);
            
            Product_Information__c cp6 = createProductInformation(black.Id, de, crcId, 45, null, null, false);
            Product_Information__c cp7 = createProductInformation(black.Id, fr, crcId, 45, null, null, false);
            Product_Information__c cp8 = createProductInformation(black.Id, es, crcId, 45, null, null, false);
            Product_Information__c cp9 = createProductInformation(black.Id, it, crcId, 45, null, null, false);
            Product_Information__c cp10 = createProductInformation(black.Id, uk, crcId, 45, null, null, false);
            
            Product_Information__c cp11 = createProductInformation(metal.Id, de, crcId, 45, null, null, false);
            Product_Information__c cp12 = createProductInformation(metal.Id, fr, crcId, 45, null, null, false);
            Product_Information__c cp13 = createProductInformation(metal.Id, es, crcId, 45, null, null, false);
            Product_Information__c cp14 = createProductInformation(metal.Id, it, crcId, 45, null, null, false);
            Product_Information__c cp15 = createProductInformation(metal.Id, uk, crcId, 45, null, null, false);
            
            List<Product_Information__c> prodInfos = new List<Product_Information__c>{p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15,
                ap1, ap2, ap3, ap4, ap5, ap6, ap7, ap8, ap9, ap10, ap11, ap12, ap13, ap14, ap15,
                cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8, cp9, cp10, cp11, cp12, cp13, cp14, cp15
                };
            DMLHelper.saveRecords('Product_Information__c', prodInfos, DMLHelper.ValidationType.DoInsert);
            
            Account acc = createAccount('Stark Industries', true);
            Contact con = createContact(acc.Id, 'Stark', 'Tony', 'DE', 'Standard', 'c88f0c46-eaf9-11ec-8fea-0242ac120002','Tony.Stark@StarkIndustries.com', '9876543210', false);
            Contact con1 = createContact(acc.Id, 'Barton', 'Clint', 'FR', 'Black', 'c88f0e76-eaf9-11ec-8fea-0242ac120002', 'Clint.Barton@Hawkeye.com','9988776655', false);
            Contact con2 = createContact(acc.Id, 'Romanoff', 'Natasha', 'UK', 'Metal', 'c88f10e2-eaf9-11ec-8fea-0242ac120002','Black.Widow@SecretFacility.com','9191919191', false);
            List<Contact> contacts = new List<Contact>{con, con1, con2};
            DMLHelper.saveRecords('Contact', contacts, DMLHelper.ValidationType.DoInsert);
            Case cs = CreateCase('Thanos has got all the infinity stones.', 'In Progress', 'Call', con.Id, false);
            Case cs1 = CreateCase('The whole world knows Peter Parker is Spiderman.', 'In Progress', 'Web', con1.Id, false);
            Case cs2 = CreateCase('Wada Maximoff has become Scarlet Witch, Doctor Strange has opened the multiverse', 'In Progress', 'Email', con2.Id, false);
            List<Case> cases = new List<Case>{cs, cs1, cs2};
            DMLHelper.saveRecords('Case', cases, DMLHelper.ValidationType.DoInsert);
            //Database.rollback(sp);
        }
    }
}