import { LightningElement , wire} from 'lwc';
import { publish , MessageContext } from 'lightning/messageService';
import COUNTING_UPDATED_CHANNEL from '@salesforce/messageChannel/FirstMessageChannel__c';

export default class PubLWCLMS extends LightningElement {
    @wire(MessageContext)
    messageContext;

    handleIncrement(){
        const payload = {
            Operator : 'add' , 
            Constant : 1
        }

        publish(this.messageContext , COUNTING_UPDATED_CHANNEL , payload)
    }
    handledecrement(){
        const payload = {
            Operator : 'subtract' , 
            Constant : 1
        }

        publish(this.messageContext , COUNTING_UPDATED_CHANNEL , payload)
    }
    handlemultiplication(){
        const payload = {
            Operator : 'multiply' , 
            Constant : 2
        }

        publish(this.messageContext , COUNTING_UPDATED_CHANNEL , payload)
    }
    handlereset(){
        const payload = {
            Operator : 'reset' , 
            Constant : 0
        }

        publish(this.messageContext , COUNTING_UPDATED_CHANNEL , payload)
    }
}