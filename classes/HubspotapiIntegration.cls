public class HubspotapiIntegration {

    
    public static void getHubspotContacts(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/crm/v3/objects/contacts?limit=10&archived=false&hapikey=2f60ebd3-678c-40dd-919c-bab14136ba92');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
		
   
        	

list<account> acclist = [select id ,name from account limit 2]; 

map<id,account> acc= new map<id,account>(acclist); 
        
        
        system.debug(acc.get('id'));
        
        
    }
}