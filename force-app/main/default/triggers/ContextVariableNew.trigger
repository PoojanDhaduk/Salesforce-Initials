trigger ContextVariableNew on Account (before insert) {
    for(Account acc: Trigger.new)
    {
        /*System.debug(Trigger.old);
        System.debug('Hey');
        acc.NumberOfEmployees = 100;*/
    }
}