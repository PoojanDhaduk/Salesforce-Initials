import { createElement } from 'lwc';
import WireWithProperties from 'c/wireWithProperties';
// import { getRecord } from 'lightning/uiRecordApi';

// const mockGetRecord = require('./Data/getRecord.json');


describe('c-wire-with-properties', () => {
    beforeEach(() => {
        const element = createElement('c-wire-with-properties', {
            is: WireWithProperties
        }
        );
        document.body.appendChild(element);

    })
    afterEach(() => {
        
    });

    test('@wire Test', () => {
        // const element = 
        // getRecord.emit(mockGetRecord);
        // expect()
    });
});
