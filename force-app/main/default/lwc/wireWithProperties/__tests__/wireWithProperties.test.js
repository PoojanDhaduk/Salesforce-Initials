import { createElement } from 'lwc';
import WireWithProperties from 'c/wireWithProperties';
import { getRecord} from 'lightning/uiRecordApi';
import mockGetRecord from './Data/sampleJSON.json';

// const mockGetRecord = require('./Data/sampleJSON.json');


describe('c-wire-with-properties', () => {    
    test('@wire Test', () => {
        const element = createElement('c-wire-with-properties', {
            is: WireWithProperties
        }
        );
        document.body.appendChild(element);

        getRecord.emit(mockGetRecord);
        
        return Promise.resolve().then(() =>{

            const nameElement = element.shadowRoot.querySelector('p.accountName');

            console.log(mockGetRecord.fields.Name.value);
            expect(nameElement.textContent).toBe(mockGetRecord.fields.Name.value);
        })
    });
});
