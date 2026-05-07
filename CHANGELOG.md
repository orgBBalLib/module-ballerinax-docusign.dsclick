# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added map<string|string[]> headers parameter to all resource functions for custom header support
- Added dedicated query record types per operation with @http:Query annotations for proper snake_case to camelCase mapping
- Added laxDataBinding field to ConnectionConfig (default true) for more lenient deserialization
- Added followRedirects (http:FollowRedirects?) field to ConnectionConfig
- Added cookieConfig (http:CookieConfig?) field to ConnectionConfig
- Added socketConfig (http:ClientSocketConfig) field to ConnectionConfig
- Default serviceUrl set to https://www.demo.docusign.net/clickapi in init()
- ConnectionConfig now has default empty record values for http1Settings, http2Settings, cache, responseLimits, socketConfig

### Changed
- All resource functions now return http:Response|error instead of specific typed domain objects (e.g., ClickwrapVersionsResponse, ClickwrapVersionSummaryResponse, UserAgreementResponse, etc.), breaking any code that relied on typed return values
- init() function signature changed: parameter order reversed and serviceUrl is now second with a default value, breaking callers using positional arguments
- init() function no longer accepts auth field in ConnectionConfig, removing built-in authentication support
- Removed types: ClickwrapVersion, ClickwrapVersionResponse, ClickwrapVersionSummaryResponse, ClickwrapVersionDeleteResponse, ClickwrapVersionsDeleteResponse, ClickwrapVersionsResponse, ClickwrapAgreementsResponse, ClickwrapsDeleteResponse, ClickwrapDeleteResponse, ClickWraps, UserAgreementResponse, ServiceInformation, ServiceVersion, ErrorDetails, BadRequestAnydata
- Removed custom types ClientHttp1Settings and ProxyConfig, breaking callers who used these types directly
- Resource functions with query parameters now use bundled query record types (*Queries) instead of individual named parameters, breaking existing callers
- get .../agreements/.../download return type changed from http:Response|error to error?, losing access to the response body
- ClickwrapRequest.scheduledDate field type changed from string to record{}
- ClickwrapRequest.status field type changed from string to record{}
- ConnectionConfig.auth field removed entirely
- ConnectionConfig timeout default changed from 60 to 30 seconds

### Fixed
- Replaced payload.toJson() with jsondata:toJson(payload) for more reliable JSON serialization
- Simplified httpClientConfig construction by removing verbose ensureType() calls, reducing potential runtime type errors
- Query parameter mapping now uses typed records with explicit annotations instead of generic map<anydata>, improving correctness
