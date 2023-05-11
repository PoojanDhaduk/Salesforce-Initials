// import { LightningElement ,api } from 'lwc';
// import Id from '@salesforce/user/Id';
// import USER_ID from '@salesforce/user/Id';

// export default class CurrentRecordandObjectInfo extends LightningElement {
//     @api recordId;
//     @api objectApiName;
//     userId = Id;
// }

import { LightningElement, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import fieldName from '@salesforce/schema/User.Name';
import RoleName from '@salesforce/schema/User.UserRole.Name';
import ProfileName from '@salesforce/schema/User.Profile.Name';
import ManagerName from '@salesforce/schema/User.Manager.Name';

export default class GetUserDetails extends LightningElement {
   userId = Id;
   userName;
   userRoleName;
   userProfileName;
   userManagerName;

    @wire(getRecord, { recordId: Id, fields: [fieldName, RoleName, ProfileName, ManagerName] })
    userDetails({ error, data }) {
        if (error) {
            this.error = error;     
        } else if (data) {
            if (data.fields.Name.value != null) {
                this.userName = data.fields.Name.value;
            }
            if (data.fields.UserRole.value != null) {
                this.userRoleName = data.fields.UserRole.value.fields.Name.value;
            }
            if (data.fields.Profile.value != null) {
                this.userProfileName = data.fields.Profile.value.fields.Name.value;
            }
            if (data.fields.Manager.value != null) {
                this.userManagerName = data.fields.Manager.value.fields.Name.value;
            }
        }
        console.log(JSON.stringify(data));
    }
}