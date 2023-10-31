import http from "k6/http";
import { check } from "k6";
import { textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';
import encoding from 'k6/encoding';

const vus = parseInt(__ENV.VUS);

const username = __ENV.UserName;
const password = __ENV.Password;
const encodedCredentials = encoding.b64encode(`${username}:${password}`);

export const options = {
  thresholds: {
    http_req_failed: ['rate<0.01'], // http errors should be less than 1%
    http_req_duration: ['p(95)<200'], // 95% of requests should be below 200ms
  },
  scenarios: {
    FeatureToggleController: {
      executor: "ramping-vus",
      exec: 'FeatureToggle',
      startTime: "0s",
      stages: [
        { duration: '1s', target: vus },
        { duration: '1s', target: vus },
        { duration: '1s', target: 0}
      ],
    },
    TenantController: {
        executor: "ramping-vus",
        exec: 'Tenant',
        startTime: "0s",
        stages: [
          { duration: '1s', target: vus },
          { duration: '1s', target: vus },
          { duration: '1s', target: 0}
        ],
    },
    VerficationCodeController: {
      executor: "ramping-vus",
      exec: 'VerficationCode',
      startTime: "0s",
      stages: [
        { duration: '1s', target: vus },
        { duration: '1s', target: vus },
        { duration: '1s', target: 0}
      ],
    },
  }
}

export function FeatureToggle()
   {
    console.log("FeatureToggle",Date.now());

    const GetAllFeatures = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/FeatureToggle/GetAllFeatures",
    params: {
      headers: {
        "Content-Type": "application/json",
      },
    },
  };

  const GetFeaturesById = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/FeatureToggle/GetFeaturesById 1",
    params: {
      headers: {
        "Content-Type": "application/json",
      },
    },
  };

  const responses = http.batch([GetAllFeatures,GetFeaturesById]);

  checkAPIResponses(responses, ['GetAllFeatures','GetFeaturesById'],"FeatureToggle");
}

export function Tenant()
   {
    const ranTenantName=RandomTenantName();

    const GetEnrolledUserDetails = {
      method: "GET",
      url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/Tenant/GetEnrolledUserDetails?email=sharun.prabhakar@valgenesis.com",
      params: {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${encodedCredentials}`,
        },
      },
    };

    const SignupTenant = {
      method: "POST",
      url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/Tenant/SignupTenant",
      params: {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${encodedCredentials}`,
        },
      },
      body:JSON.stringify({
        "CompanyName": ranTenantName,
        "Email": "varna@"+ranTenantName+".com",
        "FirstName": "varna",
        "LastName": "k6"
      })
    };

    const ActivateUser = {
      method: "POST",
      url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/Tenant/ActivateUser",
      params: {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${encodedCredentials}`,
        },
      },
      body:JSON.stringify({
        "userId": 165,
        "tntId": 1,
        "invitationId": 203,
        "comments": "Activated",
        "firstName": "Test1239",
        "lastName": "89"
      })
    };

    const ValidateUser = {
      method: "GET",
      url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/Tenant/ValidateUser?email=sharun.prabhakar@valgenesis.com",
      params: {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${encodedCredentials}`,
        },
      },
    };

    const ValidateUserStatus = {
      method: "GET",
      url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/Tenant/ValidateUserStatus?email=aakash.dayakar@valgenesis.com",
      params: {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${encodedCredentials}`,
        },
      },
    };

  const responses = http.batch([GetEnrolledUserDetails,SignupTenant,ActivateUser,ValidateUser,ValidateUserStatus]);
  checkAPIResponses(responses, ['GetEnrolledUserDetails','SignupTenant','ActivateUser','ValidateUser','ValidateUserStatus'],"Tenant");
}

export function VerficationCode()
   {
    const SendEmail = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/VerficationCode/SendEmail",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${encodedCredentials}`
        },
    },
    body:JSON.stringify({
      "email": "sharun.prabhakar@valgenesis.com",
      "verificationCode": "something"
    })
  };

  const VerifyEmail = {
    method: "POST",
    url: "https://dronaapimgmtservice.azure-api.net/develop/onboard/api/v1/VerficationCode/VerifyEmail",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${encodedCredentials}`
        },
    },
    body:JSON.stringify({
      "email": "sharun.prabhakar@valgenesis.com",    
      "verificationCode": "701782"
    })
  };

  const responses = http.batch([SendEmail,VerifyEmail]);
  checkAPIResponses(responses, ['SendEmail','VerifyEmail'],"VerficationCode");

  console.log(responses[1].status);
  console.log(responses[1].body);
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
    'stdout': textSummary(data, { indent: ' ', enableColors: true }), // Show the text summary to stdout...
    'summary.json': JSON.stringify(data), // and a JSON with all the details...
  };
}

function RandomTenantName() {
  const alphabet = 'abcdefghijklmnopqrstuvwxyz';
  const randomString = [...Array(10)]
    .map(() => alphabet[Math.floor(Math.random() * alphabet.length)])
    .join('');

  const tenantName = `kSix${randomString}`;
  return tenantName;
}
