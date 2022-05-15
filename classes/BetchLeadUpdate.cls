global class BetchLeadUpdate implements Database.Batchable<sObject>,Schedulable
{
    global database.QueryLocator start(database.Batchablecontext bc)
    {
        
        return database.getQueryLocator([select AnnualRevenue from lead]);
        
    }
    
    global void execute(database.Batchablecontext bc, list<lead> llist)
    {
        for(lead l : llist)
        {
            l.annualRevenue =20000;
        }
        update llist;
    }
	
    
    global void finish(database.BatchableContext bc)
    {
        messaging.SingleEmailMessage mail= new messaging.SingleEmailMessage();
        
        string[] toAddress = new string[]{'sunilchenani12@gmail.com', 'sunilchenani48@gmail.com'};
            
            mail.setToAddresses(toAddress);
            
            mail.setSubject('batch jod ');

			mail.setPlainTextBody('hey, do your best');        
            messaging.sendEmail(new messaging.SingleEmailMessage[]{mail});
        
        
    }

    global void execute(SchedulableContext sc)
    {
        BetchLeadUpdate lub= new BetchLeadUpdate();
        Database.executeBatch(lub,300);
        
    }
    
}