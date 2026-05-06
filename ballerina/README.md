## Overview

[DocuSign](https://www.docusign.com/) is a leading electronic signature and agreement cloud platform that enables organizations to automate the agreement process, allowing users to sign, send, and manage documents digitally from virtually anywhere.

The `ballerinax/docusign.dsclick` package offers APIs to connect and interact with [DocuSign Click API](https://developers.docusign.com/docs/click-api/) endpoints, specifically based on [DocuSign Click API v1](https://developers.docusign.com/docs/click-api/reference/).
## Setup guide

To use the DocuSign Click connector, you must have access to the DocuSign Click API through a [DocuSign developer account](https://developers.docusign.com/) and obtain an API access token. If you do not have a DocuSign account, you can sign up for one [here](https://www.docusign.com/free-trial).

### Step 1: Create a DocuSign Account

1. Navigate to the [DocuSign website](https://www.docusign.com/) and sign up for an account or log in if you already have one.

2. For development and testing purposes, create a free [DocuSign Developer Account](https://developers.docusign.com/). Note that DocuSign Click API access in production requires a DocuSign Click subscription, which is available as an add-on to DocuSign eSignature plans or included in certain enterprise agreements.

### Step 2: Generate an API Access Token

1. Log in to your [DocuSign Developer Account](https://account-d.docusign.com/).

2. Navigate to the **Settings** page by clicking on your profile icon in the top right corner and selecting **My Apps & Keys** (or go to **Apps and Keys** under the **Integrations** section in Settings).

3. Click **Add App and Integration Key** to create a new application.

4. Provide an **App Name** for your integration and click **Create App**.

5. Copy the **Integration Key** (Client ID) displayed for your application.

6. Under **Authentication**, configure your preferred authentication method (Authorization Code Grant or JWT Grant) and add the required redirect URIs.

7. To generate an access token for testing, you can use the **Get Access Token** feature in the DocuSign Developer Center or implement the OAuth 2.0 flow in your application.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `docusign.dsclick` connector in your Ballerina application, update the `.bal` file as follows:

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
            consentButtonText: "I Agree",
            format: "modal"
        },
        status: {"value": "active"}
    };

    http:Response response = check dsclickClient->/v1/accounts/["<Your_Account_ID>"]/clickwraps.post(newClickwrap);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `DocuSign Click` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples), covering the following use cases:

1. [Return policy agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/return-policy-agreement) - Demonstrates how to create and manage return policy agreements using Ballerina connector for DocuSign Click.
2. [Terms and conditions agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/terms-and-conditions-agreement) - Illustrates implementing terms and conditions clickwrap agreements for user consent.