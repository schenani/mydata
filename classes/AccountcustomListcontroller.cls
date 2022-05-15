public class AccountcustomListcontroller 
{
    public list<account> acclist{get;set;}
    
    public AccountcustomListcontroller()
    {
        acclist=[select name, numberofemployees, type from account where numberofemployees >100 order by name];
        
    }

}