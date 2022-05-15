public class AccountHelperClass {
    
     public static void my(List<Account> acc)
    {
        list<contact> con = new list <contact>();
    
        for(Account a:acc)
        {
            decimal j =0;
            if(a.NumberofLocations__c != null)
            {
                j = a.NumberofLocations__c;
            }
            for(integer i=1;i<=j;i++)
            {
                contact c = new contact();
                c.accountid=a.Id;
                c.LastName = 'contri'+ i;
                con.add(c);
            }
        }
    
    		insert con;
    }
    
    
   	 public static void my1(Map<Id, Account> acc)
     {	
     		   
         	list<opportunity> opp=[select id,StageName,AccountId,CreatedDate from opportunity where AccountId in :acc.keySet()];
         	
         	system.debug('sunil'+ acc.keySet());
         	List<Opportunity> oppUpdate=new List<Opportunity>();
         	for(opportunity op:opp)
            {
                if(op.StageName != 'Closed Won' && op.CreatedDate == Date.today().addDays(-30) )
              {
               	  op.StageName = 'close lost';
             
                  oppUpdate.add(op);
              }
            }  
        
         update oppUpdate;
     }
    
  
}