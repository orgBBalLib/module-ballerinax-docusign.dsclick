# Return Policy Agreement

This example demonstrates how to create and manage a return policy clickwrap agreement using DocuSign Click. The script creates a new clickwrap with a PDF document, retrieves its details, updates the display settings, fetches user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://central.ballerina.io/ballerinax/docusign.dsclick/latest) to obtain your OAuth2 credentials and account details.

2. **PDF Document**
   > Place your return policy PDF document at `./resources/README.pdf` relative to your project directory.

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

   > **Note:** You can also set these values as environment variables (`CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN`, `REFRESH_URL`, `ACCOUNT_ID`, `USER_ID`, `SERVICE_URL`) instead of using the `Config.toml` file.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the clickwrap creation, retrieval, update, user agreements, and deletion responses.

```shell
bal run
```