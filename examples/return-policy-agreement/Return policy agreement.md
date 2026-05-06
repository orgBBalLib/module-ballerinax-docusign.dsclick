# Return Policy Agreement

This example demonstrates how to manage DocuSign Click clickwrap agreements for a return policy. The script creates a new clickwrap with a PDF document, retrieves and updates the clickwrap, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/ballerina#setup-guide) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Create a `resources` directory in your project root and place a PDF file named `README.pdf` that will serve as the return policy document.

3. **Configuration**
   
   Create a `Config.toml` file in the project root with your DocuSign credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   refreshUrl = "<Your Refresh URL>"
   accountId = "<Your Account ID>"
   userId = "<Your User ID>"
   serviceUrl = "<Your Service URL>"
   ```

   > **Note:** You can also set these values as environment variables (`CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN`, `REFRESH_URL`, `ACCOUNT_ID`, `USER_ID`, `SERVICE_URL`) as the code reads from environment variables with `os:getEnv()`.

## Run the Example

Execute the following command to run the example. The script will create a return policy clickwrap, retrieve its details, update the display name, list user agreements, and delete the clickwrap, printing the responses to the console.

```shell
bal run
```