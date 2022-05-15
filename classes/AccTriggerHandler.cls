public class AccTriggerHandler 
{
    public static void Preventdeleteq4(Map<Id, account> acc)
        
    {
        
        list<account> acclist =[select id, (select accountid,name from Opportunities 
                               	where Stagename != 'closed won' or stagename != 'closed lose') 
                                from account where id in :acc.keySet()];
        
        for(account a : acclist)
        {
            if( a.opportunities.size() > 0)
            {
                acc.get(a.Id).adderror('account can not be delete');    
            }
        }
        
    }
    
}