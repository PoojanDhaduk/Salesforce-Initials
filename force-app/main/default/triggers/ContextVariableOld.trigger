trigger ContextVariableOld on Account (before update) {
    for(Account oldAcc: Trigger.old)
    {
        for(Account newAcc: Trigger.new)
        {
            if(oldAcc.id == newAcc.id && oldAcc.AnnualRevenue != newAcc.AnnualRevenue)
                newAcc.Description = 'Annual Revenue Changed from ' + oldAcc.AnnualRevenue + ' To '  + newAcc.AnnualRevenue;
        }
    }
}