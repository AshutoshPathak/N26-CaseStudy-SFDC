public class DMLHelper {
    public static void saveRecords(String objectApiName, List<SObject> recordsToSave, ValidationType valType){
        if(recordsToSave == null || recordsToSave.isEmpty())
            return;
        SObject obj = recordsToSave[0];
        Boolean hasPermission = hasPermission(objectApiName, obj, valType);
        if(!hasPermission)
            throw new DMLHelperException('User does not have necessary permissions to perform the operation');
        else{
            switch on valType{
                when DoInsert{
                    INSERT recordsToSave;
                }
                when DoUpdate{
                    UPDATE recordsToSave;
                }
                when DoDelete{
                    DELETE recordsToSave;
                } 
            }
        }
    }
    
    private static Boolean hasPermission(String objectApiName, SObject objToCheck, ValidationType valType){
        SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName);
        Boolean result = false;
        switch on valType{
            when DoInsert{
                result =  sObjectType.getDescribe().isCreateable();
            }
            when DoUpdate{
                result =  sObjectType.getDescribe().isUpdateable();
            }
            when DoDelete{
                result =  sObjectType.getDescribe().isDeletable();
            }
        }
        return result;
    }
    
    
    public enum ValidationType{DoInsert, DoUpdate, DoDelete}
    public class DMLHelperException extends Exception{}
    
}