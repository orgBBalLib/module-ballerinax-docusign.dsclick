# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- All resource functions now accept map<string|string[]> headers parameter for custom per-request HTTP headers
- New typed query parameter records added: ClickwrapsGetClickwrapsQueries, ClickwrapsDeleteClickwrapsQueries, ClickwrapsDeleteClickwrapQueries, ClickwrapVersionsDeleteClickwrapVersionsQueries, UserAgreementsGetClickwrapAgreementsQueries, UserAgreementsGetClickwrapVersionAgreementsQueries
- ConnectionConfig gains new fields: followRedirects, cookieConfig, socketConfig, laxDataBinding
- Default serviceUrl set to https://www.demo.docusign.net/clickapi
- Query record fields use @http:Query annotations for snake_case to camelCase name mapping
- ClickwrapScheduledReacceptance gains startDateTime field

### Changed
- All resource functions now return raw http:Response|error instead of typed response records (e.g., ClickwrapVersionSummaryResponse, UserAgreementResponse, ClickwrapVersionsResponse, etc.)
- init() function signature changed: serviceUrl moved to second parameter with default value, ConnectionConfig moved to first parameter with default value
- auth field removed from ConnectionConfig - authentication can no longer be configured via ConnectionConfig
- ClientHttp1Settings custom type removed and replaced with http:ClientHttp1Settings
- ProxyConfig custom type removed and replaced with http:ProxyConfig
- ClickwrapVersionResponse type removed
- ClickwrapVersionSummaryResponse type removed
- ClickwrapVersionDeleteResponse type removed
- ClickwrapVersionsDeleteResponse type removed
- ClickwrapVersionsResponse type removed
- ClickwrapVersionsPagedResponse type removed
- ClickwrapAgreementsResponse type removed
- ClickwrapsDeleteResponse type removed
- ClickwrapDeleteResponse type removed
- ClickwrapVersion type removed
- UserAgreementResponse type removed
- ServiceInformation type removed
- ServiceVersion type removed
- ErrorDetails type removed
- ClickWraps type removed
- BadRequestAnydata type removed
- Individual query parameters replaced with typed query record spreads, breaking all existing call sites
- Download endpoint return type changed from http:Response|error to error?, making response body inaccessible
- ClickwrapRequest.scheduledDate field type changed from string to record {}
- ClickwrapRequest.status field type changed from string to record {}
- timeout default value changed from 60 to 30 seconds

### Fixed
- Replaced verbose ensureType-based config initialization with direct struct spread, reducing boilerplate and potential runtime errors
- Switched from payload.toJson() to jsondata:toJson(payload) for more reliable JSON serialisation
- Default values added for http1Settings, http2Settings, cache, responseLimits, socketConfig in ConnectionConfig to prevent nil issues
