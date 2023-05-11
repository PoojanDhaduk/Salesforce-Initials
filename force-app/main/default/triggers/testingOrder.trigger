trigger testingOrder on Order (after update ,before update) {

   System.debug('Trigger ran!!!');
    System.debug(trigger.new);
    System.debug(trigger.old);
    
      
}