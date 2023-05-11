import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';


export default class PubsubChild1 extends LightningElement {
    buttonhandler(event){
        console.log("Inside this")
        this.eventPublisher("Hello From Child One");
    }
    eventPublisher(data){
        console.log('inside event publisher');
        pubsub.publish("sayHello1" , data);
    }
}