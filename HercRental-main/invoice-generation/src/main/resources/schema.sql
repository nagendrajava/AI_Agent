CREATE TABLE IF NOT EXISTS `hercrentals`.`invoice_audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_type` varchar(100) DEFAULT NULL,
  `invoice_number` varchar(100) DEFAULT NULL,
  `customer_number` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `event_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `input_bucket_name` varchar(255) NOT NULL,
  `output_bucket_name` varchar(255) NOT NULL,
  `input_xml_file` varchar(1024) NOT NULL,
  `output_pdf_file` varchar(1024) DEFAULT NULL,
  `overall_status` varchar(50) DEFAULT 'In Progress',
  `request_type` varchar(20) NOT NULL,
  `total_execution_duration` bigint unsigned DEFAULT NULL,
  `last_updated_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `hercrentals`.`invoice_processing_audit_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audit_id` int DEFAULT NULL,
  `function_name` varchar(255) DEFAULT NULL,
  `execution_stage` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `execution_duration` bigint unsigned DEFAULT NULL,
  `event_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `error_type` varchar(200) DEFAULT NULL,
  `error_message` varchar(400) DEFAULT NULL,
  `error_stack` text,
  PRIMARY KEY (`id`),
  KEY `audit_id` (`audit_id`),
  CONSTRAINT `invoice_processing_audit_log_1` FOREIGN KEY (`audit_id`) REFERENCES `invoice_audit_log` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;