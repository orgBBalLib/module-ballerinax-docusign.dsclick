# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added map<string|string[]> headers parameter to all resource functions for custom header support
- Added dedicated Queries record types: ClickwrapsGetClickwrapsQueries, ClickwrapsDeleteClickwrapsQueries, ClickwrapsDeleteClickwrapQueries, ClickwrapVersionsDeleteClickwrapVersionsQueries, UserAgreementsGetClickwrapAgreementsQueries, UserAgreementsGetClickwrapVersionAgreementsQueries
- Added @http:Query annotations for camelCase-to-snake_case query parameter name mapping
- Added followRedirects, cookieConfig, socketConfig, and laxDataBinding fields to ConnectionConfig
- Default serviceUrl set to https://www.demo.docusign.net/clickapi in init()
- Added import for ballerina/data.jsondata for improved JSON serialisation

### Changed
- All resource functions now return http:Response|error instead of typed response types (e.g., ClickwrapVersionSummaryResponse, UserAgreementResponse, ClickwrapVersionResponse, etc.), requiring callers to manually deserialise responses
- init() function signature changed: parameter order swapped and serviceUrl is now optional with a default value, breaking positional callers
- auth field removed from ConnectionConfig, breaking any callers using built-in authentication configuration
- Removed types: ClickwrapVersionSummaryResponse, ClickwrapVersionResponse, ClickwrapVersionDeleteResponse, ClickwrapVersionsDeleteResponse, ClickwrapVersionsResponse, ClickwrapVersionsPagedResponse, ClickwrapAgreementsResponse, ClickwrapsDeleteResponse, ClickwrapDeleteResponse, ClickwrapVersion, UserAgreementResponse, ServiceInformation, ServiceVersion, ErrorDetails, ClickWraps, BadRequestAnydata
- Removed custom ClientHttp1Settings and ProxyConfig wrapper types, replaced with native http: equivalents
- Individual named query parameters removed from resource function signatures, replaced with grouped Queries record types
- ClickwrapRequest.scheduledDate field type changed from string to record {}
- ClickwrapRequest.status field type changed from string to record {}
- get_service_information now returns http:Response|error instead of ServiceInformation|error
- Download endpoint return type changed from http:Response|error to error?, discarding the response body
- timeout default value changed from 60 to 30 seconds in ConnectionConfig

### Fixed
- Simplified init() by removing complex ensureType casting logic, reducing potential runtime errors
- Replaced payload.toJson() with jsondata:toJson(payload) for more reliable JSON serialisation
- ConnectionConfig fields http1Settings, http2Settings, cache, responseLimits, socketConfig now have proper default values instead of being optional
