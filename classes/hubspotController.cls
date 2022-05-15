public class hubspotController {
    @future(callout=true)
    public static void getHubspotContacts(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/crm/v3/objects/contacts?limit=10&archived=false&hapikey=2f60ebd3-678c-40dd-919c-bab14136ba92');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            
            List<Object> dataList = (List<Object>) results.get('results');
            list<contact> con = new list<contact>();
            
            
         
            for(integer i=0;i<dataList.size();i++) {
                Map<String, Object> alist=(Map<String, object>)dataList[i];
                Map<String, Object> blist=(Map<String, object>)alist.get('properties');
            
                string email = (string)blist.get('email');
                string fname = (string)blist.get('firstname');
                string lastname = (string)blist.get('lastname');
                
                // insertion in contact salesforce
                contact c=new contact();
                c.firstname = fname;    
                c.lastname= lastname;
                c.email= email;
                system.debug(c);
                con.add(c);        
            }
            upsert con;
        }
      
    }

}