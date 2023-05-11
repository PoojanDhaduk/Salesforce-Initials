import { LightningElement , api } from 'lwc';

export default class Basic extends LightningElement {
    prefix = "Hello..."
    inputName= "Salesforce Buddy";
    handleChange(event){
        if(event.target.value === ""){
            this.inputName = this.prefix + "Salesforce Buddy ";
        }
        else{ 
            this.inputName = this.prefix + event.target.value;
        }
    }
    @api
    callingParent () { 
        console.log("Hello World");
    }


}
