import http from "k6/http";

const authToken = __ENV.AUTH_TOKEN;
console.log('Access Token:', authToken);


export const options = {
    scenarios: {
      ApiKeyGeneratorController: {
        executor: "per-vu-iterations",
        exec: 'ApiKeyGenerator',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      GroupController: {
        executor: "per-vu-iterations",
        exec: 'Group',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      GroupTypeController: {
        executor: "per-vu-iterations",
        exec: 'GroupType',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      RoleController: {
        executor: "per-vu-iterations",
        exec: 'Role',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      RoleTypeController: {
        executor: "per-vu-iterations",
        exec: 'RoleType',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      UserController: {
        executor: "per-vu-iterations",
        exec: 'User',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      UserTypeController: {
        executor: "per-vu-iterations",
        exec: 'UserType',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      MetaDataController: {
        executor: "per-vu-iterations",
        exec: 'MetaData',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      OperatorTypeController: {
        executor: "per-vu-iterations",
        exec: 'OperatorType',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      OrganizationController: {
        executor: "per-vu-iterations",
        exec: 'Organization',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
      PermissionController: {
        executor: "per-vu-iterations",
        exec: 'Permission',
        vus: 1,
        iterations: 1,
        startTime: "0s",
      },
    },
  };

  export function Group() {
    const groupName = `k6_test_${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;

    console.log('Access Token1:', authToken);

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
      "id": Math.floor(Math.random() * 1000) + 1,
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
      "id": Math.floor(Math.random() * 1000) + 1,
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
  
  const responses = http.batch([GetActive, Create,Update,Deactivate,Reactivate,Terminate,GetDetail,GetBatch]);

      //console.log(responses[0].body);
       //console.log(responses[1].body);
      //console.log(responses[2].body);
      //console.log(responses[3].body);
      // console.log(responses[4].body);
      // console.log(responses[5].body);
      // console.log(responses[6].body);
      // console.log(responses[7].body);

  }

  export function Role()
   {
    const roleName = `k6_test_Role${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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
      "id": Math.floor(Math.random() * 1000) + 1,
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
      "id": Math.floor(Math.random() * 1000) + 1,
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
      "id":  Math.floor(Math.random() * 1000) + 1,
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
  // console.log(responses[2].body);
  // console.log(responses[3].body);
  // console.log(responses[4].body);
  // console.log(responses[5].body);
 // console.log(responses[6].body);
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

  //console.log(responses[0].body);

}

export function User()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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
      "id": Math.floor(Math.random() * 1000) + 1,
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

  const Terminate = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/User/Terminate",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
      "id": Math.floor(Math.random() * 1000) + 1,
      "comments": "Terminate"
    })
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
      "id": Math.floor(Math.random() * 1000) + 1,
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
  const responses = http.batch([GetActive,SendInvitation,Update,GetUser,RevokeInvite,Reactivate,Deactivate,GetBatch,GetActiveUserByGroupType,Terminate,Invite,UpdateProfile,GetUserBusinessStructure]);

  //console.log(responses[12].body);

}

export function UserType()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

 // console.log(responses[0].body);
}

export function ApiKeyGenerator()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

    const GetActive = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/manage/api/v1/ApiKeyGenerator",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };
  const responses = http.batch([GetActive]);

  //console.log(responses[0].body);
}

export function GroupType()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

  console.log(responses[0].body);
}

export function MetaData()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

  //console.log(responses[0].body);
  //console.log(responses[1].body);
  //console.log(responses[2].body);

}

export function OperatorType()
   {
    const uniqueName = `k6_test_User${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

  console.log(responses[0].body);
}

export function Organization()
   {
    const uniqueorganizationName = `k6Test_Organization${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

  //console.log(responses[1].body);
}

export function Permission()
   {
    const uniqueorganizationName = `k6Test_Organization${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 1000) + 1;
    const newrandomNum=Math.floor(Math.random() * 1000) + 1;

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

  //console.log(responses[1].body);
}


