public with sharing class EmployeeBoardController {
    public EmployeeBoardController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Custom_Event__c> getEvents(){
        try {
            return [SELECT Id, Stage__c, Description__c FROM Custom_Event__c ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}