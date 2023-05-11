import { LightningElement } from 'lwc';

export default class BodyLWC extends LightningElement {
    handleButtonClick(event){
        console.log(event.currentTarget);
    }
}