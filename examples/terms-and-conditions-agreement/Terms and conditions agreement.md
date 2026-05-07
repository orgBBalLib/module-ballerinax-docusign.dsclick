# Terms and Conditions Agreement

This example demonstrates how to create, manage, and delete a Terms and Conditions clickwrap agreement using the DocuSign Click API. The script creates a clickwrap from a PDF document, retrieves its details, updates the display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Click Setup**
   > Refer to the [DocuSign Click setup guide](https://central.ballerina.io/ballerinax/docusign.dsclick/latest) to obtain your OAuth2 credentials, account ID, and service URL.

2. **PDF Document**
   Create a `resources` directory in your project root and place your Terms and Conditions PDF file named `Terms.pdf` inside it.

3. **Configuration**
   Create a `Config.toml` file in the project root with your credentials:

   ```toml
   clientId = "<Your Client ID>"
   clientSecret = "<Your Client Secret>"
   refreshToken = "<Your Refresh Token>"
   refreshUrl = "<Your Refresh URL>"
   accountId = "<Your DocuSign Account ID>"
   userId = "<Your User ID>"
   serviceUrl = "<Your DocuSign Click Service URL>"
   ```

   > **Note:** The `refreshUrl` is typically `https://account-d.docusign.com/oauth/token` for the developer environment or `https://account.docusign.com/oauth/token` for production.

## Run the Example

Execute the following command to run the example. The script will print the progress of each operation to the console.

```shell
bal run
```

The script performs the following operations in sequence:
1. Creates a new clickwrap with the Terms and Conditions PDF
2. Retrieves the created clickwrap details
3. Updates the clickwrap display name
4. Lists all user agreements for the clickwrap version
5. Deletes the clickwrap