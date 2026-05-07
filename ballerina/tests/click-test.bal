// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// versionId 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/os;
import ballerina/lang.array;
import ballerina/io;
import ballerina/http;

Client docuSignClient = test:mock(Client);

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string accountId = ?;
configurable string userId = ?;

@test:BeforeSuite
function initializeClientsForDocuSignServer() returns error? {
    if isTestOnLiveServer {
        docuSignClient = check new (
            serviceUrl = "https://demo.docusign.net/clickapi/",
            config = {
                timeout: 10000
            }
        );
    } else {
        docuSignClient = check new (
            serviceUrl = "http://localhost:9092/clickapi",
            config = {
                timeout: 10000
            }
        );
    }
}

@test:Config {
    groups: ["account"]
}
function testServiceInfo() returns error? {
    record {
        string buildVersion?;
        string[] linkedSites?;
        record {string version?; string versionUrl?;}[] serviceVersions?;
    } expectedPayload = {
        buildVersion: "23.4.0.266 (apiclick2023.10.29.266+b6661c114fe2)",
        linkedSites: ["https://demo.docusign.net"],
        serviceVersions: [
            {
                version:"v1",
                versionUrl:"https://demo.docusign.net/clickapi/v1"
            }
        ]
    };
    http:Response response = check docuSignClient->/service_information;
    json responseJson = check response.getJsonPayload();
    record {
        string buildVersion?;
        string[] linkedSites?;
        record {string version?; string versionUrl?;}[] serviceVersions?;
    } serviceInfo = check responseJson.cloneWithType();
    test:assertEquals(serviceInfo, expectedPayload);
}

@test:Config {
    groups: ["account"]
}
function testCreateClickWrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapNameJson = responseJson.clickwrapName;
    string? responseClickwrapName = clickwrapNameJson is json ? <string?>clickwrapNameJson : ();
    test:assertEquals(responseClickwrapName, clickwrapName);
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["account"]
}
function testDeleteClickWrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapNameJson = responseJson.clickwrapName;
    string? responseClickwrapName = clickwrapNameJson is json ? <string?>clickwrapNameJson : ();
    test:assertEquals(responseClickwrapName, clickwrapName);
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    http:Response deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    json deleteResponseJson = check deleteResponse.getJsonPayload();
    json|error deleteClickwrapIdJson = deleteResponseJson.clickwrapId;
    string? deleteClickwrapId = deleteClickwrapIdJson is json ? <string?>deleteClickwrapIdJson : ();
    test:assertEquals(deleteClickwrapId, clickwrapId);
}

@test:Config {}
function testGetSingleClickwrap() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    http:Response getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]();
    json getResponseJson = check getResponse.getJsonPayload();
    json|error getAccountIdJson = getResponseJson.accountId;
    string? getAccountId = getAccountIdJson is json ? <string?>getAccountIdJson : ();
    test:assertEquals(getAccountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {}
function testGetAllClickwraps() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    http:Response allClickwrapsResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps();
    json allClickwrapsJson = check allClickwrapsResponse.getJsonPayload();
    json|error clickwrapsResult = allClickwrapsJson.clickwraps;
    json? clickwraps = clickwrapsResult is json ? clickwrapsResult : ();
    test:assertNotEquals(clickwraps, ());
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["clickwrap"]
}
function testDeleteClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    json|error versionNumberJson = responseJson.versionNumber;
    string? versionNumber = versionNumberJson is json ? <string?>versionNumberJson : ();
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].delete();
    json deleteResponseJson = check deleteResponse.getJsonPayload();
    json|error deleteVersionNumberJson = deleteResponseJson.versionNumber;
    string? deleteVersionNumber = deleteVersionNumberJson is json ? <string?>deleteVersionNumberJson : ();
    test:assertEquals(deleteVersionNumber, versionNumber);
}

@test:Config {
    groups: ["clickwrap"]
}
function testGetClickwrapAgreementsByVersionNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    json|error versionNumberJson = responseJson.versionNumber;
    string? versionNumber = versionNumberJson is json ? <string?>versionNumberJson : ();
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]/users();
    json agreementResponseJson = check agreementResponse.getJsonPayload();
    json|error userAgreementsResult = agreementResponseJson.userAgreements;
    json? userAgreements = userAgreementsResult is json ? userAgreementsResult : ();
    test:assertEquals(userAgreements, []);
}

@test:Config {
    groups: ["clickwrap"]
}
function testGetClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        }
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    json|error versionNumberJson = responseJson.versionNumber;
    string? versionNumber = versionNumberJson is json ? <string?>versionNumberJson : ();
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]();
    json getResponseJson = check getResponse.getJsonPayload();
    json|error getAccountIdJson = getResponseJson.accountId;
    string? getAccountId = getAccountIdJson is json ? <string?>getAccountIdJson : ();
    test:assertEquals(getAccountId, accountId);
    _ = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
}

@test:Config {
    groups: ["clickwrap"]
}
function testUpdateClickwrapVersionByNumber() returns error? {
    string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true
        }
    };
    string clickwrapUpdatedName = "Updated Clickwrap";
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error clickwrapIdJson = responseJson.clickwrapId;
    string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    json|error versionNumberJson = responseJson.versionNumber;
    string? versionNumber = versionNumberJson is json ? <string?>versionNumberJson : ();
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response updateRes = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].put({
        clickwrapName: clickwrapUpdatedName
    });
    json updateResJson = check updateRes.getJsonPayload();
    json|error updatedClickwrapNameJson = updateResJson.clickwrapName;
    string? updatedClickwrapName = updatedClickwrapNameJson is json ? <string?>updatedClickwrapNameJson : ();
    test:assertEquals(updatedClickwrapName, clickwrapUpdatedName);
}

@test:Config {}
function testPostUserAgreement() returns error? {
   string base64Encoded = array:toBase64(check io:fileReadBytes("resources/README.txt"));
    string clickwrapName = "ReturnPolicy";
    ClickwrapRequest payload =  {
        clickwrapName: clickwrapName,
        documents: [
            {
                documentName: "Test Doc",
                documentBase64: base64Encoded,
                fileExtension: "pdf"
            }
        ],
        displaySettings: {
            displayName: "Return Policy",
            consentButtonText: "I Agree",
            downloadable: true,
            format: "modal",
            requireAccept: true,
            documentDisplay: "document",
            sendToEmail: true 
        },
        status: {"value": "active"}
    };
    http:Response response = check docuSignClient->/v1/accounts/[accountId]/clickwraps.post(payload);
    json responseJson = check response.getJsonPayload();
    json|error statusJson = responseJson.status;
    string? status = statusJson is json ? <string?>statusJson : ();
    if status == "active" {
        json|error clickwrapIdJson = responseJson.clickwrapId;
        string? clickwrapId = clickwrapIdJson is json ? <string?>clickwrapIdJson : ();
        if clickwrapId is () {
            return error("Clickwrap Id is not available");
        }
        http:Response agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/agreements.post({
            clientUserId: userId
        });
        json agreementResponseJson = check agreementResponse.getJsonPayload();
        json|error agreementAccountIdJson = agreementResponseJson.accountId;
        string? agreementAccountId = agreementAccountIdJson is json ? <string?>agreementAccountIdJson : ();
        test:assertEquals(agreementAccountId, accountId);
    }
}