import http from "k6/http";
import { sleep, check } from 'k6';

export const options = {
    // define thresholds
    thresholds: {
      http_req_failed: ['rate<0.01'], // http errors should be less than 1%
      http_req_duration: ["p(99)<300"], // 99% of requests should be below 1s
    },
    scenarios: {
        // arbitrary name of scenario
        average_load: {
          executor: "ramping-vus",
          stages: [
            // ramp up to average load of 20 virtual users
            { duration: "10s", target: 200 },
            // maintain load
            { duration: "50s", target: 20 },
            // ramp down to zero
            { duration: "5s", target: 0 },
          ],
        },
      }
  };

export default function() {
    const url = "https://dronaapimgmtservice.azure-api.net/develop/dataprotection/api/DataProtection/Encode";
   
    const payload = JSON.stringify({
        TenantId: 1, 
    });

    const params = {
        headers: {
            "Content-Type": "application/json",
        },
    };
    const res = http.post(url,payload,params);

    // Add checks to validate the response
    check(res, {
        'Status is 200': (r) => r.status === 200,
        'Response Time is less than 500ms': (r) => r.timings.duration < 500,
    });

    console.log(res.body);
    sleep(10); // Add a sleep to control the request rate (in seconds)
}

