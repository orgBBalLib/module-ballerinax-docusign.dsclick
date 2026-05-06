# Terms and Conditions Agreement

This example demonstrates how to create and manage a Terms and Conditions clickwrap agreement using DocuSign Click. The script creates a clickwrap with a PDF document, retrieves its details, updates the display settings, lists user agreements, and then deletes the clickwrap.

## Prerequisites

1. **DocuSign Setup**
   > Refer to the [DocuSign Click setup guide](https://github.com/ballerina-platform/ballerina-library/blob/main/ballerina/docusign.dsclick/Module.md#setup-guide) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **PDF Document**
   > Place a PDF file named `Terms.pdf` in a `resources` directory at the root of your project. This file will be used as the terms and conditions document.

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

   > **Note:** The `refreshUrl` is typically `https://account-d.docusign.com/oauth/token` for the developer environment.

## Run the Example

Execute the following command to run the example. The script will create a clickwrap agreement, display its details, update it, list user agreements, and finally delete the clickwrap, printing the results to the console at each step.

```shell
bal run
```