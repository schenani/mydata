@RestResource(urlMapping='/webhook/tfi')
global class Tfi {
    @HttpPost
    global static string firstMethod() {
        try{
            RestRequest request = restContext.request;
            RestResponse res = restContext.response;
            System.debug('call');
            System.debug('request.headers > '+request.headers);
            System.debug('request.headers > '+request.requestBody);
      
        }catch(Exception e){
            System.debug('exception > '+e);
        }
        
        return 'hello2';
    }
}