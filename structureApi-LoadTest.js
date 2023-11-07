import http from "k6/http";
import { check } from "k6";
import { textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

const authToken = __ENV.AUTH_TOKEN;
const vus = parseInt(__ENV.VUS) || 1;
const initialDuration=__ENV.DURATION || '1s';

export const options = {
  thresholds: {
    http_req_failed: [__ENV.HTTP_REQ_FAILED_THRESHOLD || 'rate<0.15'], //eg: 'rate<0.15'[request failure rate must be 15 percentage]
    http_req_duration: [__ENV.HTTP_REQ_DURATION_THRESHOLD || 'p(95)<5000'], //eg: 'p(95)<5000' [95% of req must be less than 5s(5000ms)]
  },
  scenarios: {
    BusinessStructureController: {
      executor: "ramping-vus",
      exec: 'BusinessStructure',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
    DepartmentController: {
      executor: "ramping-vus",
      exec: 'Department',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
    JobTitleController: {
      executor: "ramping-vus",
      exec: 'JobTitle',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
  }
}

export function BusinessStructure() {
    const randomName = `k6_test${Date.now()}`;
    const randomNum=Math.floor(Math.random() * 10) + 1;

    const GetDepartments = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetDepartments?businessStrucureId=1&departmentId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetJobTitles = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetJobTitles?businessStrucureId=1&jobTitleId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetRoles = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetRoles?businessStrucureId=1&roleId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const Create = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Create",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
        "businessStructureName": randomName,
        "businessStructurePrefix": randomName,
    })
  }

  const Update = {
    method: "PUT",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Update",
    params: {
      headers: {    
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
    body:JSON.stringify({
        "businessStructureName": "k6_test1699268220235",
        "businessStructurePrefix": "k6_test1699268220235",
        "businessStructureId": 7,
        "comments": "k6Test",
        "businessStructureStatus": 0
    })
  }

  const Get = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Get?id="+randomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetBatch = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetBatch?BatchNumber"+randomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetActive = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetActive",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetBusinessStructures = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetBusinessStructures",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetParentBusinessStructureUpdate = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetParentBusinessStructureUpdate?businessStructureId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetParents = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetParents",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetChildren = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetChildren?locationtree="+randomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

  const GetEntities = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/GetEntities?businessstructureid="+randomNum,
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  }

//   const Deactivate = {
//     method: "PUT",
//     url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Deactivate",
//     params: {
//       headers: {    
//         "Content-Type": "application/json",
//         Authorization: `Bearer ${authToken}`,
//       },
//     },
//     body:JSON.stringify({
//         "id": 168,
//         "comments": "string"
//     })
//   }

// const Reactivate = {
//     method: "PUT",
//     url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Deactivate",
//     params: {
//       headers: {    
//         "Content-Type": "application/json",
//         Authorization: `Bearer ${authToken}`,
//       },
//     },
//     body:JSON.stringify({
//         "id": 168,
//         "comments": "string"
//     })
//   }

//   const Terminate = {
//     method: "PUT",
//     url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/BusinessStructure/Terminate",
//     params: {
//       headers: {    
//         "Content-Type": "application/json",
//         Authorization: `Bearer ${authToken}`,
//       },
//     },
//     body:JSON.stringify({
//         "id": 168,
//         "comments": "string"
//     })
//   }
  
  const responses = http.batch([GetDepartments, GetJobTitles, GetRoles, Create,Update,Get,GetBatch,GetActive,GetBusinessStructures,
    GetParentBusinessStructureUpdate,GetParents,GetChildren,GetEntities]);

  checkAPIResponses(responses, ['GetDepartments', 'GetJobTitles', 'GetRoles', 'Create', 'Update','Get','GetBatch','GetActive',
  'GetBusinessStructures','GetParentBusinessStructureUpdate','GetParents','GetChildren','GetEntities'],"BusinessStructure");
}

export function Department() {
  const randomName = `k6_test${Date.now()}`;
  const randomNum=Math.floor(Math.random() * 10) + 1;

  const Create = {
  method: "POST",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Create",
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
  body:JSON.stringify({
    "departmentName": randomName,
    "businessStructureId": 1
})
}

const Update = {
  method: "PUT",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Update",
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
  body:JSON.stringify({
    "departmentId": 7,
    "departmentName": "k6_test1699261839774",
    "departmentNumber": "D0007",
    "businessStructureId": 1,
    "comments": "string"
})
}

const Get = {
  method: "GET",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Get?id="+randomNum,
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  }
}

const GetBatch = {
  method: "GET",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/GetBatch?BatchNumber=1&BatchSize=10",
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  }
}

// const Deactivate = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Deactivate",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Deactivated"
// })
// }

// const Reactivate = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Reactivate",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Reactivate"
// })
// }

// const Terminated = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/Department/Terminated",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Terminated"
// })
// }

const responses = http.batch([Create,Update,Get,GetBatch]);
checkAPIResponses(responses, ['Create','Update','Get','GetBatch'],"Department");
}

export function JobTitle() {
  const randomName = `k6_test${Date.now()}`;
  const randomNum=Math.floor(Math.random() * 10) + 1;

  const Create = {
  method: "POST",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Create",
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
  body:JSON.stringify({
    "jobTitleName": randomName,
    "businessStructureId": 7
})
}

const Update = {
  method: "PUT",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Update",
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
  body:JSON.stringify({
    "jobTitleId": randomNum,
    "jobTitleName": randomName,
    "businessStructureId": 7,
    "comments": "k6 updated"
})
}

const Get = {
  method: "GET",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Get?id="+randomNum,
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
}

const GetBatch = {
  method: "GET",
  url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/GetBatch?BatchNumber=1&BatchSize="+randomNum,
  params: {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${authToken}`,
    },
  },
}

// const Deactivate = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Deactivate",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Deactivated"
// })
// }

// const Reactivate = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Reactivate",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Reactivate"
// })
// }

// const Terminated = {
//   method: "PUT",
//   url: "https://dronaapimgmtservice.azure-api.net/develop/structure/api/v1/JobTitle/Terminated",
//   params: {
//     headers: {
//       "Content-Type": "application/json",
//       Authorization: `Bearer ${authToken}`,
//     },
//   },
//   body:JSON.stringify({
//     "Id": randomNum,
//     "Comments": "Terminated"
// })
// }
const responses = http.batch([Create,Update,Get,GetBatch]);
checkAPIResponses(responses, ['Create','Update','Get','GetBatch'],"JobTitle");
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