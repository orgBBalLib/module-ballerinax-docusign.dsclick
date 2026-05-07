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
    json jsonResponse = check response.getJsonPayload();
    record {
        string buildVersion?;
        string[] linkedSites?;
        record {string version?; string versionUrl?;}[] serviceVersions?;
    } actualResponse = check jsonResponse.cloneWithType();
    test:assertEquals(actualResponse, expectedPayload);
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
    json jsonResponse = check response.getJsonPayload();
    string? responseClickwrapName = <string?>check jsonResponse.clickwrapName;
    test:assertEquals(responseClickwrapName, clickwrapName);
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
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
    json jsonResponse = check response.getJsonPayload();
    string? responseClickwrapName = <string?>check jsonResponse.clickwrapName;
    test:assertEquals(responseClickwrapName, clickwrapName);
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    http:Response deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId].delete();
    json deleteJsonResponse = check deleteResponse.getJsonPayload();
    string? deleteClickwrapId = <string?>check deleteJsonResponse.clickwrapId;
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
    json jsonResponse = check response.getJsonPayload();
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    http:Response getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]();
    json getJsonResponse = check getResponse.getJsonPayload();
    string? getAccountId = <string?>check getJsonResponse.accountId;
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
    json jsonResponse = check response.getJsonPayload();
    http:Response allClickwrapsResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps();
    json allClickwrapsJson = check allClickwrapsResponse.getJsonPayload();
    json? clickwraps = check allClickwrapsJson.clickwraps;
    test:assertNotEquals(clickwraps, ());
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
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
    json jsonResponse = check response.getJsonPayload();
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = <string?>check jsonResponse.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response deleteResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].delete();
    json deleteJsonResponse = check deleteResponse.getJsonPayload();
    string? deleteVersionNumber = <string?>check deleteJsonResponse.versionNumber;
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
    json jsonResponse = check response.getJsonPayload();
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = <string?>check jsonResponse.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]/users();
    json agreementJsonResponse = check agreementResponse.getJsonPayload();
    json? userAgreements = check agreementJsonResponse.userAgreements;
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
    json jsonResponse = check response.getJsonPayload();
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = <string?>check jsonResponse.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response getResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber]();
    json getJsonResponse = check getResponse.getJsonPayload();
    string? getAccountId = <string?>check getJsonResponse.accountId;
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
    json jsonResponse = check response.getJsonPayload();
    string? clickwrapId = <string?>check jsonResponse.clickwrapId;
    if clickwrapId is () {
        return error("Clickwrap Id is not available");
    }
    string? versionNumber = <string?>check jsonResponse.versionNumber;
    if versionNumber is () {
        return error("Version number is not available");
    }
    http:Response updateRes = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/versions/[versionNumber].put({
        clickwrapName: clickwrapUpdatedName
    });
    json updateJsonResponse = check updateRes.getJsonPayload();
    string? updatedClickwrapName = <string?>check updateJsonResponse.clickwrapName;
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
    json jsonResponse = check response.getJsonPayload();
    string? status = <string?>check jsonResponse.status;
    if status == "active" {
        string? clickwrapId = <string?>check jsonResponse.clickwrapId;
        if clickwrapId is () {
            return error("Clickwrap Id is not available");
        }
        http:Response agreementResponse = check docuSignClient->/v1/accounts/[accountId]/clickwraps/[clickwrapId]/agreements.post({
            clientUserId: userId
        });
        json agreementJsonResponse = check agreementResponse.getJsonPayload();
        string? agreementAccountId = <string?>check agreementJsonResponse.accountId;
        test:assertEquals(agreementAccountId, accountId);
    }
}