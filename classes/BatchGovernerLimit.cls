global class BatchGovernerLimit implements database.Batchable<sObject>,DataBase.Stateful,Database.AllowsCallouts{
    
     global Integer DailyApiRequests_Remain=0;
     global Integer DailyApiRequests_Uti=0;
     global Integer DailyApiRequests_RPer=0;
     global Integer DailyApiRequests_total=0;
    
     global Integer DailyBulkApiRequests_Remain=0;
     global Integer DailyBulkApiRequests_Uti=0;
     global Integer DailyBulkApiRequests_RPer=0;
     global Integer DailyBulkApiRequests_total=0;
    
     global Integer DataStorageMB_Remain=0;
     global Integer DataStorageMB_Uti=0;
     global Integer DataStorageMB_RPer=0;
     global Integer DataStorageMB_total=0;
    
        global Integer DailyStreamingApiEvents_Remain=0;
        global Integer DailyStreamingApiEvents_Uti=0;
        global Integer DailyStreamingApiEvents_RPer=0;
       global Integer DailyStreamingApiEvents_total=0;
        
        global Integer DailyAsyncApexExecutions_Remain=0;
        global Integer DailyAsyncApexExecutions_Uti=0;
        global Integer DailyAsyncApexExecutions_RPer=0;
       global Integer DailyAsyncApexExecutions_total=0;
    
      global Integer DailyWorkflowEmails_Remain=0;
      global Integer DailyWorkflowEmails_Uti=0;
      global Integer DailyWorkflowEmails_RPer=0;
     global Integer DailyWorkflowEmails_total=0;
    
      global String CExternal_s='Active';
      global Integer CExternal_TL=0;
      global Integer CExternal_UL=0;
      global Integer CExternal_RL=0; 
    
      global String CFree_s='Active';
      global Integer CFree_TL=0;
      global Integer CFree_UL=0;
      global Integer CFree_RL=0;  
   
    
    global String CCL_s='Active';
      global Integer CCL_TL=0;
      global Integer CCL_UL=0;
      global Integer CCL_RL=0; 
    
    global String EI_s='Active';
      global Integer EI_TL=0;
      global Integer EI_UL=0;
      global Integer EI_RL=0; 
    
    global String FAS_s='Active';
      global Integer FAS_TL=0;
      global Integer FAS_UL=0;
      global Integer FAS_RL=0;
    
    global String IDE_s='Active';
      global Integer IDE_TL=0;
      global Integer IDE_UL=0;
      global Integer IDE_RL=0;
    
     global String SIIU_s='Active';
      global Integer SIIU_TL=0;
      global Integer SIIU_UL=0;
      global Integer SIIU_RL=0;
    
    global String SAL_s='Active';
      global Integer SAL_TL=0;
      global Integer SAL_UL=0;
      global Integer SAL_RL=0;
    
    global decimal sData=0;
    global decimal Dper=0;
    
      
    
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
         string query='select Id, Name, UsedLicenses, TotalLicenses, Status from UserLicense';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<UserLicense> userL) {
        
        Map<string,object> jsonBody=(Map<string,object>)limitApex.getLimitsResp();
        Map<string,object> DataSize=(Map<string,object>)jsonBody.get('DataSizeMB');
        Map<string,object> DailyApiRequests=(Map<string,object>)jsonBody.get('DailyApiRequests');
        Map<string,object> DailyBulkApiRequests=(Map<string,object>)jsonBody.get('DailyBulkApiRequests');
        Map<string,object> DailyStreamingApiEvents=(Map<string,object>)jsonBody.get('DailyStreamingApiEvents');
        Map<string,object> DailyAsyncApexExecutions=(Map<string,object>)jsonBody.get('DailyAsyncApexExecutions');
        Map<string,object> DailyWorkflowEmails=(Map<string,object>)jsonBody.get('DailyWorkflowEmails');
        system.debug(DailyWorkflowEmails);
        
        
        
        	DailyApiRequests_total=(integer)DailyApiRequests.get('Max');
            DailyApiRequests_Remain=(integer)DailyApiRequests.get('Remaining');
            DailyApiRequests_Uti=DailyApiRequests_total-DailyApiRequests_Remain;
            DailyApiRequests_RPer=(DailyApiRequests_Remain*100)/DailyApiRequests_total;
        
        
            DailyBulkApiRequests_total=(integer)DailyBulkApiRequests.get('Max');
            DailyBulkApiRequests_Remain=(integer)DailyBulkApiRequests.get('Remaining');
            DailyBulkApiRequests_Uti=DailyBulkApiRequests_total-DailyBulkApiRequests_Remain;
            DailyBulkApiRequests_RPer=(DailyBulkApiRequests_Remain*100)/DailyBulkApiRequests_total;
        
        
            DataStorageMB_total=(integer)DataSize.get('Max');
            DataStorageMB_Remain=(integer)DataSize.get('Remaining');
            DataStorageMB_Uti=DataStorageMB_total-DataStorageMB_Remain;
            DataStorageMB_RPer=(DataStorageMB_Remain*100)/DataStorageMB_total;
            sData=(decimal)DataStorageMB_total/1024;
            dper=(decimal)DataStorageMB_RPer;
        
            DailyStreamingApiEvents_total=(integer)DailyStreamingApiEvents.get('Max');
            DailyStreamingApiEvents_Remain=(integer)DailyStreamingApiEvents.get('Remaining');
            DailyStreamingApiEvents_Uti=DailyStreamingApiEvents_total-DailyStreamingApiEvents_Remain;
            DailyStreamingApiEvents_RPer=(DailyStreamingApiEvents_Remain*100)/DailyStreamingApiEvents_total;
        
            DailyAsyncApexExecutions_total=(integer)DailyAsyncApexExecutions.get('Max');
            DailyAsyncApexExecutions_Remain=(integer)DailyAsyncApexExecutions.get('Remaining');
            DailyAsyncApexExecutions_Uti=DailyAsyncApexExecutions_total-DailyAsyncApexExecutions_Remain;
            DailyAsyncApexExecutions_RPer=(DailyAsyncApexExecutions_Remain*100)/DailyAsyncApexExecutions_total;
 


   
        
        
        
        for(UserLicense u:userL){
            system.debug('user name'+u.Name);
            system.debug('TL'+u.TotalLicenses);
            
            if(u.Name=='Chatter External'){
                system.debug('chatter');
                
                CExternal_s=u.Status;
                CExternal_TL=u.TotalLicenses;
                CExternal_UL=u.UsedLicenses;
                CExternal_RL=CExternal_TL-CExternal_UL;
                
                
            }
             if(u.Name=='Chatter Free'){
                 system.debug('Free');
                 CFree_s=u.Status;
                 CFree_TL=u.TotalLicenses;
                 CFree_UL=u.UsedLicenses;
                 CFree_RL=CFree_TL-CFree_UL;
                
            }
             if(u.Name=='Customer Community Login'){
                  system.debug('ccl');
                 
                 CCL_s=u.Status;
                 CCL_TL=u.TotalLicenses;
                 CCL_UL=u.UsedLicenses;
                 CCL_RL=CCL_TL-CCL_UL;
                
            }
             if(u.Name=='External Identity'){
                  system.debug('ei');
                 EI_s=u.Status;
                 EI_TL=u.TotalLicenses;
                 EI_UL=u.UsedLicenses;
                 EI_RL=EI_TL-EI_UL;
                
            }
             if(u.Name=='Force.com - App Subscription'){
                  system.debug('fas');
                 FAS_s=u.Status;
                 FAS_TL+=u.TotalLicenses;
                 FAS_UL+=u.UsedLicenses;
                 FAS_RL+=FAS_TL-FAS_UL;
                
            }
            if(u.Name=='Identity'){
                IDE_s=u.Status;
                 IDE_TL=u.TotalLicenses;
                 IDE_UL=u.UsedLicenses;
                 IDE_RL=IDE_TL-IDE_UL;
                
            }
            if(u.Name=='Sales Insights Integration User'){
                 SIIU_s=u.Status;
                 SIIU_TL=u.TotalLicenses;
                 SIIU_UL=u.UsedLicenses;
                 SIIU_RL=SIIU_TL-SIIU_UL;
                
            }
             if(u.Name=='Salesforce'){
                 SAL_s=u.Status;
                 SAL_TL=u.TotalLicenses;
                 SAL_UL=u.UsedLicenses;
                 SAL_RL=SAL_TL-SAL_UL;
                
            }
        }
        
        
        
    }
    global void finish(Database.BatchableContext BC) {
         

         Messaging.SingleEmailMessage email=new messaging.SingleEmailMessage();
         email.setSubject('contactBatch');
         email.setSenderDisplayName('sunil chenani');
         email.setHtmlBody('Governor Limit <br/><table>'+
                           '<th>Governor Limits</th><th>Total Available</th><th>Remaining</th><th>Utilized</th><th>%Remaining</th>'+
                           '<tr>'+
                           '<td>DailyApiRequests</td><td></td><td>'+DailyApiRequests_Remain+'</td><td>'+DailyApiRequests_Uti+'</td><td>'+DailyApiRequests_RPer+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>DailyBulkApiRequests</td><td></td><td>'+DailyBulkApiRequests_Remain+'</td><td>'+DailyBulkApiRequests_Uti+'</td><td>'+DailyBulkApiRequests_RPer+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>DataStorageMB</td><td></td><td>'+DataStorageMB_Remain+'</td><td>'+DataStorageMB_Uti+'</td><td>'+DataStorageMB_RPer+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>DailyStreamingApiEvents</td><td></td><td>'+DailyStreamingApiEvents_Remain+'</td><td>'+DailyStreamingApiEvents_Uti+'</td><td>'+DailyStreamingApiEvents_RPer+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>DailyAsyncApexExecutions</td><td></td><td>'+DailyAsyncApexExecutions_Remain+'</td><td>'+DailyAsyncApexExecutions_Uti+'</td><td>'+DailyAsyncApexExecutions_RPer+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>DailyWorkflowEmails</td><td></td><td>'+DailyWorkflowEmails_Remain+'</td><td>'+DailyWorkflowEmails_Uti+'</td><td>'+DailyWorkflowEmails_RPer+'</td>'+
                           '</tr>'+
                           '</table>'+
                          '<br/>License Utilization <br/><table>'+
                           '<th>Name</th><th>Status</th><th>Total Licenses</th><th>Used Licenses</th><th>Remaining Licenses</th>'+
                           '<tr>'+
                           '<td>Chatter External</td><td>'+CExternal_s+'</td><td>'+CExternal_TL+'</td><td>'+CExternal_UL+'</td><td>'+CExternal_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Chatter Free</td><td>'+CFree_s+'</td><td>'+CFree_TL+'</td><td>'+CFree_UL+'</td><td>'+CFree_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Customer Community Login</td><td>'+CCL_s+'</td><td>'+CCL_TL+'</td><td>'+CCL_UL+'</td><td>'+CCL_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>External Identity</td><td>'+EI_s+'</td><td>'+EI_TL+'</td><td>'+EI_UL+'</td><td>'+EI_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Force.com - App Subscription</td><td>'+FAS_s+'</td><td>'+FAS_TL+'</td><td>'+FAS_UL+'</td><td>'+FAS_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Identity</td><td>'+IDE_s+'</td><td>'+IDE_TL+'</td><td>'+IDE_UL+'</td><td>'+IDE_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Sales Insights Integration User</td><td>'+SIIU_s+'</td><td>'+SIIU_TL+'</td><td>'+SIIU_UL+'</td><td>'+SIIU_RL+'</td>'+
                           '</tr>'+
                           '<tr>'+
                           '<td>Salesforce</td><td>'+SAL_s+'</td><td>'+SAL_TL+'</td><td>'+SAL_UL+'</td><td>'+SAL_RL+'</td>'+
                           '</tr>'+
                           '</table>'+
                          '<br/>License Utilization <br/><table>'+
                           '<tr>'+
                           '<td>'+sData+'</td><td>'+dPer+'</td><td>'+
                           '</tr>'+
                          '</table>');
         List<String> emailTo=new List<String>();
         emailTo.add('sunilchenani12@gmail.com');
         email.setToAddresses(emailTo);
         Messaging.SingleEmailMessage[] emailList = new List<messaging.SingleEmailMessage>();
         emailList.add(email);
         Messaging.sendEmail(emailList,false);
         
        
        
       
    }   

}