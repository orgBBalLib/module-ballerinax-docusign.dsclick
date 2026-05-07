# Terms and Conditions Agreement

This example demonstrates how to create and manage a terms and conditions clickwrap agreement using DocuSign Click. The script creates a clickwrap from a PDF document, retrieves its details, updates the display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://central.ballerina.io/ballerinax/docusign.dsclick/latest) to obtain OAuth2 credentials and configure your DocuSign developer account.

2. **Terms Document**
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

   > **Note:** You can obtain these values from your DocuSign developer account. The `serviceUrl` is typically `https://demo.docusign.net/clickapi` for development environments.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console as it creates, updates, and manages the clickwrap agreement.

```shell
bal run
```

The script will perform the following operations sequentially:
1. Create a new clickwrap with the terms and conditions document
2. Retrieve the clickwrap details
3. Update the clickwrap display name
4. List all user agreements for the clickwrap
5. Delete the clickwrap