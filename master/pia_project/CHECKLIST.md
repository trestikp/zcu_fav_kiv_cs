## Features
- [x] Service provides API (REST or GraphQL, we'll discuss both during the labs) described by API documentation.
- [x] Service enables Bike location updates via WebSockets.
- [x] Service enables Bike location subscriptions via WebSockets or Server-Sent Events (SSE).
- [ ] Web UI is translated to English and one more language, it allows switching languages easily.
- [x] Users can log in using two authentication methods (username/password, OAuth, Kerberos, WebAuthn, OTP, ...).

## Deployment and Maintenance
- [x] Service can be run with one command, preferably using Docker Compose.

## Implementation Requirements
- [x] Correct implementation of selected architecture
- [x] Correct separation of application layers
- [x] Reasonably long methods (typically 50-100 lines, exceptions allowed)
- [x] Well-commented methods/functions, data models, attributes
- [x] Logs written where appropriate and structured (log levels, common format)
- [ ] Bike ride management module covered with automated tests (unit, integration)
- [x] Configurations must be read from property files, environment variables etc.
