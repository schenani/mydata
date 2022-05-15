public class OpportunityHelperClass {
    	
    public static void my(Map<id,opportunity> oppmap, Map<id,opportunity> opp1map){
        
        list<opportunity> opp = [select name, stagename from opportunity where id in : oppmap.keySet() and  stagename !='Closed Won'];
        
          list<Opportunity> oppNew = new list<Opportunity>();
        	
        
        for(opportunity o : opp)
        {
            Opportunity newOpportunity = opp1map.get(o.id);
          	
           
                if(newOpportunity.stagename=='Closed Won'){
             
            newOpportunity.closeDate=System.today();
             
            newOpportunity.type='New Customer';
                
                }
            
            oppNew.add(newOpportunity);
        }
        
        
    }
}