# Return Policy Agreement

This example demonstrates how to create, update, retrieve, and delete a DocuSign Click clickwrap agreement for a return policy. The script creates a clickwrap with a PDF document, updates its display settings, retrieves user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/tree/main/ballerinax/docusign.dsclick/Module.md) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Place a PDF file named `README.pdf` in a `resources` directory within your project. This file will be used as the clickwrap document.

3. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your DocuSign credentials:

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

Execute the following command to run the example. The script will create a return policy clickwrap, update it, retrieve user agreements, and delete the clickwrap, printing the responses to the console.

```shell
bal run
```