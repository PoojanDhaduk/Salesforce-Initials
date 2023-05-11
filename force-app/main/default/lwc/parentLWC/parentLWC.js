import { LightningElement } from 'lwc';

export default class ParentLWC extends LightningElement {
    handleButtonClick(event){
        console.log(event.currentTarget);
    }
    helloWorldprint(){
        console.log('Inside helloWorldPrint Method');
        this.template.querySelector('c-child-l-w-c').helloWorldMethod();
    }
}