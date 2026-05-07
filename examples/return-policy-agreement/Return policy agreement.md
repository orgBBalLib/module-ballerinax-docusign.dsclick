# Return Policy Agreement

This example demonstrates how to manage clickwrap agreements using the DocuSign Click API. The script creates a return policy clickwrap with a PDF document, retrieves and updates the clickwrap, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/tree/main/ballerinax/docusign.dsclick/Module.md) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Place a PDF file named `README.pdf` in a `resources` directory within your project. This file will be used as the clickwrap document content.

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

   > **Note:** You can also set these values as environment variables (`CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN`, `REFRESH_URL`, `ACCOUNT_ID`, `USER_ID`, `SERVICE_URL`) as the code reads from environment variables by default.

## Run the Example

Execute the following command to run the example. The script will create a return policy clickwrap, update it, retrieve user agreements, and delete the clickwrap, printing the results to the console.

```shell
bal run
```