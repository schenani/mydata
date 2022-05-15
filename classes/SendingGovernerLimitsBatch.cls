public with sharing class SendingGovernerLimitsBatch implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id FROM Account LIMIT 10';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope){

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://s2labs62-dev-ed.lightning.force.com/services/data/v47.0/limits/');
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        HttpResponse res = http.send(req);

        while(res.getStatusCode() == 302) {
            req.setEndpoint(res.getHeader('Location'));
            res = new Http().send(req);
        }

        System.debug('response ' + res.getStatus());
        System.debug('response ' + res.getStatusCode());
        System.debug('response ' + res.getBody());        

        Map<String, ApiResponse> mapRes = (Map<String, ApiResponse>)JSON.deserialize(res.getBody(), Map<String, ApiResponse>.Class);
        Map<String, ApiResponse> emailToLimits = new Map<String, ApiResponse>();

        Set<String> limitsToSend = new Set<String>{'DailyApiRequests', 'DailyBulkApiRequests', 'DataStorageMB', 'DailyStreamingApiEvents', 'DailyAsyncApexExecutions', 'DailyWorkflowEmails', 'FileStorageMB'};


        for(String limitName : mapRes.keySet()){
            // system.debug('limitName -> ' + limitName + ' value -> ' + mapRes.get(limitName));
            if(limitsToSend.contains(limitName)){
                emailToLimits.put(limitName, mapRes.get(limitName));
                System.debug('emailToLimits --> ' + limitName + ' value --> ' + mapRes.get(limitName));
            }
            
        }

        //License Utilization
        List<UserLicense> licenseLSt = [SELECT Id, LicenseDefinitionKey, TotalLicenses, Status, UsedLicenses, Name, MasterLabel FROM UserLicense];

        //Get Uers
        Users__c u = Users__c.getInstance();
        List<String> userNameLSt = u.UsersName__c.split(',');

        List<User> userLSt = [select id, name, Email, profile.name from user where name in :userNameLSt];
        
    }

    public void finish(Database.BatchableContext BC){

    }

    public class ApiResponse{
        Integer Max;
        Integer Remaining;
    }
}