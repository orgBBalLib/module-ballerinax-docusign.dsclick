# Terms and Conditions Agreement

This example demonstrates how to create, manage, and delete clickwrap agreements using the DocuSign Click API. The script creates a Terms and Conditions clickwrap with a PDF document, retrieves its details, updates the display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Setup**
   > Refer to the [DocuSign setup guide](https://central.ballerina.io/ballerinax/docusign.dsclick/latest) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Place a PDF file named `Terms.pdf` in a `resources` directory within your project. This file will be used as the Terms and Conditions document for the clickwrap.

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

Execute the following command to run the example. The script will print its progress to the console as it creates, retrieves, updates, and deletes the clickwrap agreement.

```shell
bal run
```