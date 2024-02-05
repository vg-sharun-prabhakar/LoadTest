import http from "k6/http";
import { check } from "k6";
import { textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

const authToken = __ENV.AUTH_TOKEN;
const vus = parseInt(__ENV.VUS) || 1;
const initialDuration=__ENV.DURATION || '1';

export const options = {
  thresholds: {
    http_req_failed: [__ENV.HTTP_REQ_FAILED_THRESHOLD || 'rate<0.15'], //eg: 'rate<0.15'[request failure rate must be 15 percentage]
    http_req_duration: [__ENV.HTTP_REQ_DURATION_THRESHOLD || 'p(95)<5000'], //eg: 'p(95)<5000' [95% of req must be less than 5s(5000ms)]
  },
  scenarios: {
    ApiKeyGeneratorController: {
      executor: "ramping-vus",
      exec: 'ApiKeyGenerator',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
    GroupController: {
      executor: "ramping-vus",
      exec: 'Group',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
      GroupTypeController: {
        executor: "ramping-vus",
        exec: 'GroupType',
        startTime: "0s",
        stages: [
          { duration: initialDuration, target: vus },
          { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
          { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
        ],
      },
    // RoleController: {
    //     executor: "ramping-vus",
    //     exec: 'Role',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   RoleTypeController: {
    //     executor: "ramping-vus",
    //     exec: 'RoleType',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   UserController: {
    //     executor: "ramping-vus",
    //     startTime: "0s",
    //     exec: 'User',
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   UserTypeController: {
    //     executor: "ramping-vus",
    //     startTime: "0s",
    //     exec: 'UserType',
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   MetaDataController: {
    //     executor: "ramping-vus",
    //     exec: 'MetaData',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   OperatorTypeController: {
    //     executor: "ramping-vus",
    //     exec: 'OperatorType',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   OrganizationController: {
    //     executor: "ramping-vus",
    //     exec: 'Organization',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    //   PermissionController: {
    //     executor: "ramping-vus",
    //     exec: 'Permission',
    //     startTime: "0s",
    //     stages: [
    //       { duration: initialDuration, target: vus },
    //       { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
    //       { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
    //     ],
    //   },
    },
  };

  export function Group() {
    const groupName = `k6_test_${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 10) + 1;

    const GetActive = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/GetActive",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const Create = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Create",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      groupName: groupName,
      groupTypeId: 1,
      businessStructureId: 1,
      groupUsers: [2, 3],
    })
  };

  const Update = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Update",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "groupId": randomNum, 
      "groupName": "k6test1696511520805",
      "description": "string",
      "comments": "string",
      "groupUsers": [
            2,3,4
        ] 
    })
  };

  const Deactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Deactivate",  
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "deactivate"
    })
  };

  const Reactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Reactivate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "Reactivate"
    })
  };

  const Terminate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Terminate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": randomNum,
      "comments": "Terminate"
    })
  };

  const GetDetail = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/Get?id="+randomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetBatch = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Group/GetBatch?BatchNumber=1&BatchSize=10&sortKey=groupName&sortOrder=asc&searchKey=group%201",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };
  const responses = http.batch([GetActive, Create, Update, Deactivate, Reactivate, Terminate, GetDetail, GetBatch]);
      
  checkAPIResponses(responses, ['GetActive', 'Create', 'Update', 'Deactivate', 'Reactivate', 'Terminate', 'GetDetail', 'GetBatch'],"Group");
}

  export function Role()
   {
    const roleName = `k6_test_Role${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 10) + 1;
    const newrandomNum=Math.floor(Math.random() * 10) + 1;

    const Create = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Create",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "roleName": roleName,
      "businessStructureId": 1,
      "roleTypeId": 1
    })
  };

  const Update = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Update",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
            "roleId":randomNum,
            "roleName": roleName,
            "description": "string",
            "comments": "string",
            "businessStructureId": 1
    })
  };

  const Deactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Deactivate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "Deactivate"
    })
  };

  const Reactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Reactivate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "Reactivate"
    })
  };

  const Terminate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Terminate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id":  Math.floor(Math.random() * 10) + 1,
      "comments": "Terminate"
    })
  };

  const RoleDetail = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/Get?id="+newrandomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetBatch = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Role/GetBatch?BatchNumber=1&BatchSize=10&sortKey=roleName&sortOrder=asc&searchKey=role%201",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([Create,Update,Deactivate,Reactivate,Terminate,RoleDetail,GetBatch]);

  checkAPIResponses(responses, ['Create','Update','Deactivate','Reactivate','Terminate','RoleDetail','GetBatch'],"Role");
}

export function RoleType()
   {

    const GetRoleTypes = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/RoleType/GetRoleTypes",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetRoleTypes]);

  checkAPIResponses(responses, ['GetRoleTypes'],"RoleType");
}

export function User()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 10) + 1;
    const newrandomNum=Math.floor(Math.random() * 10) + 1;

    const GetActive = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/GetActive",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const SendInvitation = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/SendInvitation",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "uniqueUserId":uniqueName,
      "firstName":"Test1239",
      "lastName":"89",
      "email":uniqueName+"@k6Test.com",
      "businessStructureId":3,
      "businessStructureText":"BS 1",
      "roleId":22,
      "roleText":"Arun",
      "departmentId":6,
      "departmentText":"Dept 123456",
      "jobTitleId":8,
      "permissions":[{"permissionId":1,"isNoAccess":false,"isReadOnly":true,"isFullAccess":false,"permissionPath":"manage"}],
      "jobTitleText":"Job Title 3",
      "userTypeId":1,
      "userTypeText":"Internal",
      "customizationNote":"testing123"
    })
  };

  const Update = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Update",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "userId": 42,
      "uniqueUserId":"ragu1",
      "firstName":"Test1239",
      "lastName":"89",
      "email":"ragu1@vg.com",
      "businessStructureId":3,
      "businessStructureText":"BS 1",
      "roleId":22,
      "roleText":"Arun",
      "departmentId":6,
      "departmentText":"Dept 123456",
      "jobTitleId":8,
      "permissions":[{"permissionId":1,"isNoAccess":false,"isReadOnly":true,"isFullAccess":false,"permissionPath":"manage"}],
      "jobTitleText":"Job Title 3",
      "userTypeId":1,
      "userTypeText":"Internal",
      "customizationNote":"testing123",
      "comments": "string"
    })
  };

  const GetUser = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Get?id=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const RevokeInvite = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/RevokeInvite",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": randomNum,
      "comments": "RevokeInvite"
    })
  };

  const Reactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Reactivate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "Reactivate"
    })
  };

  const Deactivate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Deactivate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 1000) + 1,
      "comments": "Deactivate"
    })
  };

  const GetBatch = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/GetBatch?BatchNumber=1&BatchSize=10&sortKey=uniqueUserId&sortOrder=asc&searchKey=user",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetActiveUserByGroupType = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/GetActiveUserByGroupType?groupTypeId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const Invite = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Invite",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 10) + 1,
      "comments": "Invite"
    })
  };

  const UpdateProfile = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/UpdateProfile",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
        "userId": 42,
        "address": "string",
        "email": "k6Test@vg.com",
        "phoneNumber": "98801034",
        "timeZoneId": 1
    })
  };

  const GetUserBusinessStructure = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/GetUserBusinessStructure?userId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };
  const responses = http.batch([GetActive,SendInvitation,Update,GetUser,RevokeInvite,Reactivate,Deactivate,GetBatch,GetActiveUserByGroupType,Invite,UpdateProfile,GetUserBusinessStructure]);
  checkAPIResponses(responses, ['GetActive','SendInvitation','Update','GetUser','RevokeInvite','Reactivate','Deactivate','GetBatch','GetActiveUserByGroupType','Invite','UpdateProfile','GetUserBusinessStructure'],"User");

}

export function UserType()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 10) + 1;
    const newrandomNum=Math.floor(Math.random() * 10) + 1;

    const GetUserType = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/UserType/GetUserTypes",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetUserType]);

  checkAPIResponses(responses, ['GetUserType'],"UserType");

}

export function ApiKeyGenerator()
   {
    const GetApiKey = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/ApiKeyGenerator",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };
  const responses = http.batch([GetApiKey]);

  checkAPIResponses(responses, ['GetApiKey'],"ApiKeyGenerator");
}

export function GroupType()
   {
    const GetGroupTypes = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/GroupType/GetGroupTypes",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetGroupTypes]);
  checkAPIResponses(responses, ['GetGroupTypes'],"GroupType");
}

export function MetaData()
   {
    const GetCountryCode = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/MetaData/GetCountryCode",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetTimeZone = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/MetaData/GetTimeZone",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetDefaultLandingList = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/MetaData/GetDefaultLandingList",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetCountryCode,GetTimeZone,GetDefaultLandingList]);

  checkAPIResponses(responses, ['GetCountryCode','GetTimeZone','GetDefaultLandingList'],"MetaData");
}

export function OperatorType()
   {
    const GetOperatorTypes = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/OperatorType/GetOperatorTypes",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetOperatorTypes]);

  checkAPIResponses(responses, ['GetOperatorTypes'],"Role");
}

export function Organization()
   {
    const uniqueorganizationName = `k6Test_Organization${Date.now()}`;

    const Create = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Organization/Create",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
        "organizationId": 0,
        "organizationName": uniqueorganizationName,
        "tenantId": 1,
        "businessStructureId": 1,
        "organizationStatus": 0,
        "modifiedDate": "2023-10-09T10:02:10.796Z"
    })
  };

  const GetBatch = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Organization/GetBatch?BatchNumber=1&BatchSize=10&sortKey=orgName&sortOrder=asc&searchKey=org%201",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

   const responses = http.batch([Create,GetBatch]);
   checkAPIResponses(responses, ['Create','GetBatch'],"Organization");
}

export function Permission()
   {
    const GetTree = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Permission/GetTree",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetDefaultPermission = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/Permission/GetDefaultPermission?roleType=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetTree,GetDefaultPermission]);
  checkAPIResponses(responses, ['GetTree','GetDefaultPermission'],"Permission");
}

export function checkAPIResponses(responses, apiNames,controllerName) {
  for (let i = 0; i < responses.length; i++) {
      check(responses[i], {
          [`${controllerName}.${apiNames[i]} status was 200`]: (res) => res.status === 200,
      });
  }
}

export function handleSummary(data) {
  console.log('Finished executing performance tests');

  return {
    'stdout': textSummary(data, { indent: ' ', enableColors: true }), 
    'summary.json': JSON.stringify(data), 
  };
}

