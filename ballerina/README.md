## Overview

[DocuSign](https://www.docusign.com/) is a leading electronic signature and agreement cloud platform that enables businesses to automate the agreement process, from preparing and signing to acting on and managing contracts and agreements.

The `ballerinax/docusign.dsclick` package offers APIs to connect and interact with [DocuSign Click API](https://developers.docusign.com/docs/click-api/) endpoints, specifically based on [DocuSign Click API v1](https://developers.docusign.com/docs/click-api/reference/).
## Setup guide

To use the DocuSign Click connector, you must have access to the DocuSign Click API through a [DocuSign developer account](https://developers.docusign.com/) and obtain an API access token. If you do not have a DocuSign account, you can sign up for one [here](https://www.docusign.com/free-trial).

### Step 1: Create a DocuSign Account

1. Navigate to the [DocuSign website](https://www.docusign.com/) and sign up for an account or log in if you already have one.

2. For development and testing purposes, create a free developer account at the [DocuSign Developer Center](https://developers.docusign.com/). For production use, ensure you have a DocuSign eSignature plan that includes Click API access, as Click is available as an add-on feature to Business Pro and higher plans.

### Step 2: Generate an API Access Token

1. Log in to your DocuSign Developer account at [developers.docusign.com](https://developers.docusign.com/).

2. Navigate to the **Apps and Keys** page by clicking on your profile icon in the top right corner and selecting **My Apps & Keys** (or navigate to Settings > Apps and Keys).

3. Click **Add App and Integration Key** to create a new application, or select an existing application.

4. Copy the **Integration Key** (also known as the Client ID) for your application.

5. Under the **Authentication** section, configure your authentication method. For server-to-server integrations, add an RSA keypair by clicking **Generate RSA** and securely save the private key.

6. To obtain an access token for testing, you can use the **Get Access Token** feature in the Apps and Keys page, or implement OAuth 2.0 authentication flow (Authorization Code Grant or JWT Grant) in your application.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `DocuSign Click` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/docusign.dsclick as dsclick;
```

### Step 2: Instantiate a new connector

Create a `dsclick:ConnectionConfig` and initialize the client:

```ballerina
final dsclick:Client dsclickClient = check new();
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a clickwrap

```ballerina
public function main() returns error? {
    dsclick:ClickwrapRequest newClickwrap = {
        clickwrapName: "Terms of Service Agreement",
        documents: [
            {
                documentName: "Terms and Conditions",
                documentHtml: "<html><body><h1>Terms of Service</h1><p>By using our service, you agree to these terms.</p></body></html>",
                'order: 1
            }
        ],
        displaySettings: {
            displayName: "Terms of Service",
            requireAccept: true,
            mustRead: true,
            consentButtonText: "I Agree"
        }
    };

    http:Response response = check dsclickClient->/v1/accounts/["<Your_Account_ID>"]/clickwraps.post(newClickwrap);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `docusign.dsclick` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples), covering the following use cases:

1. [Return policy agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/return-policy-agreement) - Demonstrates how to create and manage return policy clickwrap agreements using the DocuSign Click connector.
2. [Terms and conditions agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/terms-and-conditions-agreement) - Illustrates implementing terms and conditions acceptance workflows with clickwrap agreements.