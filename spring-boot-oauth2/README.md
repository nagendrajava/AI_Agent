# Spring Boot OAuth2 (Resource Server) Demo

This project was bootstrapped by find-oauth2.ps1.

## Quick start

`powershell
cd C:\Users\nagendrapa\IdeaProjects\spring-boot-oauth2
mvn -DskipTests clean package
mvn spring-boot:run
`

Endpoints:
- http://localhost:8080/public/ping
- http://localhost:8080/api/hello

To enable OAuth2 JWT validation, set:

`powershell
 = "true"
# Choose one
 = "https://YOUR_ISSUER/.well-known/openid-configuration"
# or
 = "https://YOUR_DOMAIN/.well-known/jwks.json"
`
