import http from "k6/http";
import { check } from "k6";
import { textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

const authToken = __ENV.AUTH_TOKEN;
const vus = parseInt(__ENV.VUS) || 1;
const initialDuration=__ENV.DURATION;
 
export const options = {
  thresholds: {
    http_req_failed: [__ENV.HTTP_REQ_FAILED_THRESHOLD || 'rate<0.15'], //eg: 'rate<0.15'[request failure rate must be 15 percentage]
    http_req_duration: [__ENV.HTTP_REQ_DURATION_THRESHOLD || 'p(95)<5000'], //eg: 'p(95)<5000' [95% of req must be less than 5s(5000ms)]
  },
  scenarios: {
    LanguageController: {
      executor: "ramping-vus",
      exec: 'Language',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
    LanguageResourceController: {
      executor: "ramping-vus",
      exec: 'LanguageResource',
      startTime: "0s",
      stages: [
        { duration: initialDuration, target: vus },
        { duration: `${parseFloat(initialDuration) * 3}s`, target: vus },
        { duration:  `${parseFloat(initialDuration) * 2}s`, target:0 }
      ],
    },
  }
};

export function Language() {

    const GetAll = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/Language/GetAll",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetAll]);
  checkAPIResponses(responses, ['GetAll'],"Language");

  console.log(responses[0].status)
  console.log(responses[0].body)
}

export function LanguageResource() {

    const GetResource = {
        method: "GET",
        url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetResource?key=addComments",
        params: {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${authToken}`,
          },
        },
      };

    const GetResourcesByPath = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetResourcesByPath?path=manage&languageId=1",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetResources?keys=somthing",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetAllResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetAllResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const RefreshResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/RefreshResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetRoleTypeResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetRoleTypeResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetStatusResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetStatusResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetUserStatusResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetUserStatusResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const GetGroupTypeResources = {
    method: "GET",
    url: "https://dronaapimgmtservice.azure-api.net/develop/localization/api/v1/LanguageResource/GetGroupTypeResources",
    params: {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken}`,
      },
    },
  };

  const responses = http.batch([GetResource,GetResourcesByPath,GetResources,GetAllResources,RefreshResources,GetRoleTypeResources,GetStatusResources,GetUserStatusResources,GetGroupTypeResources]);
  checkAPIResponses(responses, ['GetResource','GetResourcesByPath','GetResources','GetAllResources','RefreshResources','GetRoleTypeResources','GetStatusResources','GetUserStatusResources','GetGroupTypeResources'],"LanguageResource");

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
  


