# Herc Rentals Invoice Generation

A Spring Boot application that generates PDF invoices from XML input files using Apache FOP and distributes them through multiple channels.

## Overview

This application processes XML invoices by transforming them into PDF format using XSLT templates and Apache FOP. The generated invoices are then distributed through various endpoints including email, SnapPay, Amazon S3, SFTP, fax, printer, and FileNet.

## Features

- XML to PDF invoice generation using Apache FOP
- Two generation methods:
  - S3-triggered batch processing via Lambda
  - Real-time API for instant generation
- XSLT template-based transformation
- Multi-channel distribution support:
  - Email
  - SnapPay
  - Amazon S3
  - SFTP
  - Fax
  - Printer
  - FileNet
  - RM IFS
- Automatic retry mechanism for failed distributions
- Comprehensive audit logging in MySQL
- Multiple XSLT template versions support

## Prerequisites

- JDK 17 or higher
- Maven 3.6+
- MySQL 8.0+
- SMTP server configuration (for email distribution)
- AWS credentials (for S3 distribution)
- SFTP server access

## Configuration

The application can be configured through `application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hercrentals
spring.datasource.username=your-username
spring.datasource.password=your-password
spring.jpa.hibernate.ddl-auto=update
  
# Add other configuration properties for different distribution channels
```

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/SSudeer-Infinite/HercRental.git
   ```
 
2. Navigate to the project directory:
   ```bash
   cd invoice-generation
   ```

3. Build the project:
   ```bash
   mvn clean install
   ```

4. Run the application:
   ```bash
   mvn spring-boot:run
   ```
   
## Usage

### Batch Processing via AWS S3

The batch processing workflow:

1. Upload XML files to S3:
   - Bucket: `${S3_INPUT_BUCKET}`
   - Folder: `input_xml/`

2. AWS Lambda Trigger:
   - Automatically triggered when files are uploaded to the input folder
   - Invokes the Real-time API for each XML file
   - Monitors processing status
   - Moves unprocessed files into rejected folder in the AWS S3

### Real-time API

REST API endpoint for real-time invoice generation:
The application will:
   - Validate input XML fields against the predefined schema
   - Transform XML to PDF using Apache FOP and appropriate XSLT template
   - Distribute the generated PDF through configured channels
   - Automatically retries for failed distribution
   - Log all operations in the audit database

```bash
POST /api/invoices/generate
Content-Type: application/xml

POST /api/v3/invoices/generate
Content-Type: application/xml
```

## Distribution Process

1. **AWS S3**: Upload the generarted PDF into AWS S3 on demand
2. **Email**: Send email with the generated PDF and One Time Payment Link
3. **SnapPay**: Upload the generated PDF into Fiserv SnapPay
4. **SFTP**: Upload the generated PDF into Fiserv Prisma SFTP for printing
5. **FTP**: Upload the generated PDF into FTP folder
6. **Filenet**: Upload the generated PDF into Filenet system
7. **RM IFS**: Upload the generated PDF into RM IFS folder
8. **Fax**: Sending generated PDF via Fax
9. **Printing**: Printing the generated PDF instore

## Audit Logging

The application maintains detailed audit logs for:
- XML field validation
- PDF generation status
- Distribution status, etc

**Tables:**

Added create table script at **schema.sql** under resource
```bash
invoice_audit_log
invoice_processing_audit_log
```

## Error Handling

- Automatic retry for failed distributions
- Detailed error logging
- Error notifications through API response

## Template Versions

- **fop-template**: Initial template version
- **fop_template_v3**: Latest template version with new format changes
