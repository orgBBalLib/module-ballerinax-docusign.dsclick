# Return Policy Agreement

This example demonstrates how to manage DocuSign Click clickwrap agreements for return policies. The script creates a new clickwrap with a PDF document, retrieves its details, updates the display settings, fetches user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/tree/main/ballerinax/docusign.dsclick/Module.md) to obtain credentials.

2. **PDF Document**
   > Place a PDF file named `README.pdf` in a `resources` directory within your project. This document will be used as the return policy agreement content.

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

Execute the following command to run the example. The script will create a return policy clickwrap, retrieve and update its details, fetch user agreements, and delete the clickwrap, printing the results to the console.

```shell
bal run
```