import { LightningElement , wire} from 'lwc';
import { subscribe , MessageContext } from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/FirstMessageChannel__c';

export default class SubLWCLMS extends LightningElement {
    counter = 0;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    
    connectedCallback(){
        console.log(this.messageContext);
        this.subscribeToMessageChannel();
    }
    subscribeToMessageChannel(){
        this.subscription = subscribe(
            this.messageContext,
            COUNTING_UPDATED_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }
    handleMessage(message){
        if(message.Operator === "add"){
            this.counter = this.counter + message.Constant;
        }
        else if(message.Operator === "subtract"){
            this.counter = this.counter - message.Constant;
        }
        else if(message.Operator === "multiply"){
            this.counter = this.counter * message.Constant;
        }
        else if(message.Operator === "reset"){
            this.counter = 0;
        }
    }
}