public class Constants {
    /*
    Purpose			: Purpose of this class to keep all Constants or static text at one place
    Author			: Ashutosh Pathak
    Created Date	: 15 June 2021
	Created For		: N26 Case Study
    Version			: 1: Initial Draft 
    */
    
    public static Log Log = new Log();
    public static ProductInformation ProductInformation = new ProductInformation();
    public static Contact Contact = new Contact();
    public static Cases Cases = new Cases();
    //For LoggingUtils
    public class Log{
        public final String ObjectName =  'Log__c';
    }
    
    public class ProductInformation{
        public final String ObjectName = 'Product_Information__c';
    }
    
    public class Contact{
        public final String ObjectName = 'Contact';
    }
    
    public class Cases{
        public final String ObjectName = 'Case';
    }
    
    
}