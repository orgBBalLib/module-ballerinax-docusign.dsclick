# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added map<string|string[]> headers parameter to all resource functions for custom header passing
- Added typed query record structs: ClickwrapsGetClickwrapsQueries, ClickwrapsDeleteClickwrapsQueries, ClickwrapsDeleteClickwrapQueries, ClickwrapVersionsDeleteClickwrapVersionsQueries, UserAgreementsGetClickwrapAgreementsQueries, UserAgreementsGetClickwrapVersionAgreementsQueries
- Default service URL set to https://www.demo.docusign.net/clickapi
- Added followRedirects field to ConnectionConfig
- Added cookieConfig field to ConnectionConfig
- Added socketConfig field to ConnectionConfig
- Added laxDataBinding field to ConnectionConfig with default true
- Added @http:Query annotations for query parameter name mapping in query records

### Changed
- All resource functions now return http:Response|error instead of typed response records, removing automatic response deserialisation
- Removed ClickwrapVersionResponse type
- Removed ClickwrapVersionSummaryResponse type
- Removed ClickwrapVersionDeleteResponse type
- Removed ClickwrapVersionsDeleteResponse type
- Removed ClickwrapVersionsResponse type
- Removed ClickwrapVersionsPagedResponse type
- Removed ClickwrapAgreementsResponse type
- Removed ClickwrapsDeleteResponse type
- Removed ClickwrapDeleteResponse type
- Removed ClickWraps type
- Removed UserAgreementResponse type
- Removed ServiceInformation type
- Removed ServiceVersion type
- Removed ErrorDetails type
- Removed ClientHttp1Settings custom type
- Removed ProxyConfig custom type
- Removed BadRequestAnydata type
- Removed auth field from ConnectionConfig
- init function signature changed: serviceUrl moved to second parameter with default value, config now has default value
- Individual named query parameters replaced with typed query record structs across all resource functions
- get_service_information now returns http:Response|error instead of ServiceInformation|error
- download endpoint return type changed from http:Response|error to error?, making response body inaccessible
- ClickwrapRequest.scheduledDate type changed from string to record {}
- ClickwrapRequest.status type changed from string to record {}
- ConnectionConfig.http1Settings type changed from custom ClientHttp1Settings to http:ClientHttp1Settings
- timeout default value changed from 60 to 30 seconds

### Fixed
- Simplified client initialisation by removing verbose ensureType checks
- Switched payload serialisation from .toJson() to jsondata:toJson() for correctness
- ConnectionConfig fields http1Settings, http2Settings, cache, responseLimits, socketConfig now have explicit default empty records instead of being optional
