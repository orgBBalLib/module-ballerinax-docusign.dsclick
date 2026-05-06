# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added map<string|string[]> headers parameter to all resource functions for per-request custom headers
- New query parameter record types added: ClickwrapsGetClickwrapsQueries, ClickwrapsDeleteClickwrapsQueries, ClickwrapsDeleteClickwrapQueries, ClickwrapVersionsDeleteClickwrapVersionsQueries, UserAgreementsGetClickwrapAgreementsQueries, UserAgreementsGetClickwrapVersionAgreementsQueries
- Added @http:Query annotations for query parameter name mapping (e.g., page_number -> pageNumber, from_date -> fromDate)
- Added followRedirects (http:FollowRedirects) field to ConnectionConfig
- Added cookieConfig (http:CookieConfig) field to ConnectionConfig
- Added socketConfig (http:ClientSocketConfig) field to ConnectionConfig
- Added laxDataBinding (boolean = true) field to ConnectionConfig
- Default serviceUrl set to 'https://www.demo.docusign.net/clickapi' in init()
- Added startDateTime field to ClickwrapScheduledReacceptance

### Changed
- All resource functions now return http:Response|error instead of specific typed responses (e.g., ClickwrapVersionsResponse, UserAgreementResponse, ClickwrapVersionSummaryResponse, etc.), requiring callers to manually deserialise responses
- init() function signature changed: serviceUrl is no longer the first required parameter; both parameters now have defaults (ConnectionConfig config = {}, string serviceUrl = 'https://www.demo.docusign.net/clickapi')
- Individual named query parameters removed from resource functions and replaced with grouped query record types using spread syntax (e.g., *ClickwrapsGetClickwrapsQueries)
- Removed auth field (http:ClientAuthConfig) from ConnectionConfig, breaking any existing authentication configuration
- Removed custom ClientHttp1Settings wrapper type, replaced with http:ClientHttp1Settings directly
- Removed custom ProxyConfig wrapper type, replaced with http:ProxyConfig directly
- Removed types: ClickwrapVersion, UserAgreementResponse, ClickwrapVersionResponse, ClickwrapVersionDeleteResponse, ErrorDetails, ClickwrapsDeleteResponse, ClickwrapVersionsDeleteResponse, ClickwrapVersionSummaryResponse, ClickwrapVersionsResponse, ClickwrapVersionsPagedResponse, ClickwrapAgreementsResponse, ClickWraps, ServiceInformation, ServiceVersion, ClickwrapDeleteResponse, BadRequestAnydata
- get .../download endpoint return type changed from http:Response|error to error?, discarding the response object
- payload.toJson() replaced with jsondata:toJson(payload) requiring new import dependency ballerina/data.jsondata
- timeout default value changed from 60 to 30 seconds in ConnectionConfig

### Fixed
- Simplified client initialisation by removing verbose ensureType checks in favour of direct struct assignment
- http1Settings, http2Settings, cache, responseLimits, socketConfig now have explicit default values instead of being optional, reducing null-handling issues
- Copyright header updated to 2025 with corrected format
