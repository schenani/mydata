public class limitApex {
    public static Map<string,object> getLimitsResp() {
        HttpRequest req = new HttpRequest();
        HttpResponse res=new HttpResponse();
        Http http = new Http();
        req.setMethod('GET');
        String url = System.URL.getSalesforceBaseURL().toExternalForm() +'/services/data/v40.0/limits';
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        req.setEndpoint(url);
        res=http.send(req);
        Map<string,object> jsonBody=(Map<string,object>)json.deserializeUntyped(res.getBody());
        system.debug(jsonBody);
        //Map<string,object> DataSize=(Map<string,object>)jsonBody.get('DataSizeMB');
        //Map<string,object> DailyApiRequests=(Map<string,object>)jsonBody.get('DailyApiRequests');
        //Map<string,object> DailyBulkApiRequests=(Map<string,object>)jsonBody.get('DailyBulkApiRequests');
        //Map<string,object> DailyStreamingApiEvents=(Map<string,object>)jsonBody.get('DailyStreamingApiEvents');
        //Map<string,object> DailyAsyncApexExecutions=(Map<string,object>)jsonBody.get('DailyAsyncApexExecutions');
        //Map<string,object> DailyWorkflowEmails=(Map<string,object>)jsonBody.get('DailyWorkflowEmails');
        //system.debug(DailyWorkflowEmails);
        return jsonBody;
    }
}