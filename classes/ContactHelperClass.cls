public class ContactHelperClass 
{
    
    public static void my(List<contact> newConts)
    {
        
    Set<Id> accIds = new Set<Id>();
        
    for( Contact cont : newConts )
    {
        accIds.add( cont.AccountId );
    }
    List<Account> accs = [ SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accIds ];
    Map<Id, Integer> mMap = new Map<Id, Integer>(); 
    for( Account acc : accs ){
        mMap.put( acc.Id, acc.Contacts.size() );
    }
    for( Contact cont : newConts )
    {
        if( mMap.containsKey(cont.AccountId) )
        {
            if( mMap.get( cont.AccountId ) == 0 ){
                cont.FirstName = 'First ' + cont.FirstName;
            }
        }
    }
    }
    
    //==========================================================================
    
    
}