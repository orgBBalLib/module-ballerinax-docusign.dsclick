# Terms and Conditions Agreement

This example demonstrates how to create, manage, and delete a clickwrap agreement for terms and conditions using the DocuSign Click API. The script creates a new clickwrap with a PDF document, retrieves and updates its display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/packages/docusign.dsclick/ballerina/Module.md#setup-guide) to obtain OAuth2 credentials and account information.

2. **PDF Document**
   > Place your terms and conditions PDF file at `./resources/Terms.pdf` in the project directory.

3. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   refreshUrl = "<Your Refresh URL>"
   accountId = "<Your Account ID>"
   userId = "<Your User ID>"
   serviceUrl = "<Your Service URL>"
   ```

   > **Note:** The `refreshUrl` is typically `https://account-d.docusign.com/oauth/token` for the developer environment or `https://account.docusign.com/oauth/token` for production.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it creates, retrieves, updates, and deletes the clickwrap agreement.

```shell
bal run
```