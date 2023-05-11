import { LightningElement } from 'lwc';

export default class GrandParentLWC extends LightningElement {
    handleButtonClick(event){
        console.log(event.currentTarget);
    }
}