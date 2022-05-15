@isTest
public class AccountTriTestClass {
   
    @testsetup
    
    public static void testMethod1()
    {
        list<Account> acc = new list<Account>();
        
        integer i;
        for(i=1;i<4;i++)
        {
          account a = new account(Name ='sunil'+i , NumberofLocations__c =2);
            acc.add(a);
        }
        insert acc;
    }
    
    @isTest
    public static void testMethod2()
    {	
        	account a1 =[select name ,id from account limit 1];
			
            list<contact> con = new list <contact>();
        	contact c = new contact(LastName = 'contri', AccountId = a1.Id);
        	
                insert c;
    }
    
    @isTest
    public static void testMethod3()
    {
        	
        	account a1 =[select name ,id from account limit 1];
        
        	Opportunity o = new Opportunity(Name = 'contri', AccountId = a1.Id, CloseDate = system.today(),stagename='Prospecting');
        	
        	insert o;
        
         	List<Opportunity> oppUpdate=new List<Opportunity>();
        Opportunity oo =[select name ,id from Opportunity where name ='contri' ];	
        
              if(oo.StageName != 'Closed Won' && oo.CreatedDate == Date.today().addDays(-30) )
              {
               	  oo.StageName = 'close lost';
             
                  update oo;
              }
  
        	
        
    }
	
}