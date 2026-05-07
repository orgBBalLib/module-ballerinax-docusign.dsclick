
# Ballerina docusign.dsclick connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-docusign.dsclick.svg)](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/docusign.dsclick.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%docusign.dsclick)

## Overview

[DocuSign](https://www.docusign.com/) is a leading electronic signature and agreement cloud platform that enables organizations to automate and connect the entire agreement process, from preparing and signing to acting on and managing contracts and agreements.

The `ballerinax/docusign.dsclick` package offers APIs to connect and interact with [DocuSign Click API](https://developers.docusign.com/docs/click-api/) endpoints, specifically based on [DocuSign Click API v1](https://developers.docusign.com/docs/click-api/reference/).
## Setup guide

To use the DocuSign Click connector, you must have access to the DocuSign Click API through a [DocuSign developer account](https://developers.docusign.com/) and obtain an API access token. If you do not have a DocuSign account, you can sign up for one [here](https://www.docusign.com/products/click).

### Step 1: Create a DocuSign Account

1. Navigate to the [DocuSign website](https://www.docusign.com/) and sign up for an account or log in if you already have one.

2. For development and testing purposes, create a free developer account at the [DocuSign Developer Center](https://developers.docusign.com/). For production use, ensure you have a DocuSign plan that includes Click API access, as DocuSign Click is available as an add-on feature or included in specific enterprise plans.

### Step 2: Generate an API Access Token

1. Log in to your [DocuSign Developer Account](https://developers.docusign.com/).

2. Navigate to the **Apps and Keys** page by selecting **Settings** from the top navigation menu, then clicking **Apps and Keys** under the **Integrations** section.

3. Click **Add App and Integration Key** to create a new application, or select an existing application.

4. Copy your **Integration Key** (also known as Client ID) which serves as your application identifier.

5. To generate an access token for testing, navigate to the **API and Keys** section and use the **Get Access Token** option, or configure OAuth authentication (Authorization Code Grant or JWT Grant) for production use.

6. For quick testing, you can use the [OAuth Token Generator](https://developers.docusign.com/tools/oauth-token-generator/) tool in the DocuSign Developer Center to obtain a temporary access token.

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

The `DocuSign Click` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples), covering the following use cases:

1. [Return policy agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/return-policy-agreement) - Demonstrates how to create and manage return policy agreements using Ballerina connector for DocuSign Click.
2. [Terms and conditions agreement](https://github.com/ballerina-platform/module-ballerinax-docusign.dsclick/tree/main/examples/terms-and-conditions-agreement) - Illustrates implementing terms and conditions clickwrap agreements for user consent.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`docusign.dsclick` package](https://central.ballerina.io/ballerinax/docusign.dsclick/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
