# Terms and Conditions Agreement

This example demonstrates how to create and manage a Terms and Conditions clickwrap agreement using DocuSign Click. The script creates a clickwrap with a PDF document, retrieves its details, updates the display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/packages/docusign.dsclick/Module.md) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Place your Terms and Conditions PDF file at `./resources/Terms.pdf` relative to the project directory.

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

Execute the following command to run the example. The script will print its progress to the console as it creates, retrieves, updates, and deletes the clickwrap agreement.

```shell
bal run
```