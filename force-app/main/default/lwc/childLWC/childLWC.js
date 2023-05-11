import { LightningElement ,api } from 'lwc';

export default class ChildLWC extends LightningElement {
    constructor(){
        super();
        //
        }   
    renderedCallback(){
        this.template
        .querySelector("div")
        .addEventListener("buttonclick", this.handleButtonClick)
        // btn = this.template.querySelector('[data-id="btn"]');
        // console.log(btn);
    }
    
    handleClick(event) {
        console.log(event.currentTarget);
        // this.addEventListener('buttonclick' , this. handleButtonClick)
        const buttonclicked = new CustomEvent('buttonclick', { bubbles : false, composed : false });
        this.dispatchEvent(buttonclicked);
        }

        handleButtonClick(event){
            console.log("Hello World");
            console.log(event.currentTarget);
        }
        @api
        helloWorldMethod(){
            console.log("Hello");
        }

}