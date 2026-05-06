# Terms and Conditions Agreement

This example demonstrates how to create and manage a DocuSign Clickwrap agreement for terms and conditions. The script creates a new clickwrap with a PDF document, retrieves it, updates its display settings, lists user agreements, and finally deletes the clickwrap.

## Prerequisites

1. **DocuSign Developer Account Setup**
   > Refer to the [DocuSign DSClick setup guide](https://central.ballerina.io/ballerinax/docusign.dsclick/latest) to obtain your OAuth2 credentials and account details.

2. **PDF Document**
   Create a `resources` directory in your project root and place a `Terms.pdf` file containing your terms and conditions document.

3. **Configuration**
   Create a `Config.toml` file in the project root with your DocuSign credentials:

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

The script performs the following operations in sequence:
1. Creates a new clickwrap named "TermsAndConditions" with the provided PDF document
2. Retrieves the created clickwrap details
3. Updates the clickwrap's display name to "Updated Terms and Conditions"
4. Lists all user agreements for the clickwrap version
5. Deletes the clickwrap