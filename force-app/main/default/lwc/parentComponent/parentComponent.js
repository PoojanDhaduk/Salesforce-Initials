import { LightningElement , track } from 'lwc';

export default class ParentComponent extends LightningElement {
    @track msg;
    handleCustomEvent(event) {
        const textVal = event.detail;
        this.msg = textVal;
        this.testing();
    }
    testing(){
        this.template.querySelector('c-child-component').calledFromParent('Hello World from parent');
        this.template.querySelector('c-first-l-w-c-class').callingParent();
    }
}