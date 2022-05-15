public class taskobj {

        public static void my()
        {
           List<task> filteredaccounts = [select Description,Subject from task];

for(task act : filteredaccounts)
    {

    if(act.Description.contains('sunil')) {

        system.debug(act);

    }

	}
        }
    
}