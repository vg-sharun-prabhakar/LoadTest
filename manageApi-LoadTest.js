import http from "k6/http";
import { check } from "k6";
import { Rate } from "k6/metrics";

const authToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ii1VcUJHSTV3RjlKMXZjVl9GalpWLURrQ0s0UjMyS1Y1LXdZWmZqTWsyQVUiLCJ0eXAiOiJKV1QifQ.eyJzdWIiOiJjZWYxNjQ0OS0zZDc3LTRmYjEtYWY3OS03MjE2MTk2NDgwMmUiLCJlbWFpbCI6InNoYXJ1bi5wcmFiaGFrYXJAdmFsZ2VuZXNpcy5jb20iLCJ0bnRJZCI6MSwidXNlcklkIjo5Miwicm9sZUlkIjoxLCJyb2xlVHlwZSI6IlN1cGVyIEFkbWluIiwidG50TmFtZSI6InZhbGdlbmVzaXMiLCJidXNpbmVzc1N0cnVjdHVyZUlkIjoxLCJidXNpbmVzc1N0cnVjdHVyZU5hbWUiOiJEZWZhdWx0LUJTIiwicm9sZU5hbWUiOiJTdXBlciBBZG1pbiAxMjM0NTQ1NjciLCJidXNpbmVzc1N0cnVjdHVyZVByZWZpeCI6ImRlZmF1bHQtYnMiLCJmaXJzdE5hbWUiOiJTaGFydW4iLCJsYXN0TmFtZSI6IlNoZXR0eSIsInRpZCI6ImIyY2EwZjA0LWU2YzktNDhlMC1hNGNiLTlmMWFjYTZhNzI3MCIsInNjcCI6Ik1hbmFnZUFwaSIsImF6cCI6IjAzYmNhZTUyLWRjMzEtNDYwNS1hMzgxLTg5OGFkOWZjMTg2MCIsInZlciI6IjEuMCIsImlhdCI6MTY5Njg0OTk3NywiYXVkIjoiYjdhZjZlMWItOTE1YS00YzdjLWI0NTgtM2U1NTYxNWE4NjdmIiwiZXhwIjoxNjk2ODUzNTc3LCJpc3MiOiJodHRwczovL3ZnZHJvbmFiMmMuYjJjbG9naW4uY29tL2IyY2EwZjA0LWU2YzktNDhlMC1hNGNiLTlmMWFjYTZhNzI3MC92Mi4wLyIsIm5iZiI6MTY5Njg0OTk3N30.SqJkk8RjvKmmYthbHhBG58UkvlKfcT_CNUxy99L90sj9UVZe7BQZ6AH8UANgNLniYwQGlpeRT9vNcxAHumeDCRzId4af4UOX7ZC2eotu17a2J7EfrqPRi8zcmRW5-NEyjec0TIk4Z7O1mH70LE-ncKUARghAtGsnQYjEx2eY2VW9pEZ1ispSy6f1n_7r8hKo2c0KA1isRL_AFr1mm5ubzc5a4ng3rGGJr4XSkYZ7aVs1nJ8sujSCkFrkaziA3clOKHuWn3Q8UUHgbouOJw_oH6J-OGphdl-0eWlmiK59QWDDK0rm5NdVge2RBMXJgzufI4Ays14k8NoZaCEEieLC-w";

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

  console.log(responses[1].body);
}

