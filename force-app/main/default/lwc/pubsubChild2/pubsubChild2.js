import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class PubsubChild2 extends LightningElement {
    connectedCallback(){
        this.callSubscriber()
    }
    callSubscriber(){
        pubsub.subscribe("sayHello1" , this.subscriberCallback1);
        pubsub.subscribe("sayHello2" , this.subscriberCallback2);
    }
    displayfun(){
        pubsub.displayStore();
    }
    subscriberCallback1(event){
        console.log(event + 'first');
    }
    subscriberCallback2(event){
        console.log(event + 'second');
    }
}