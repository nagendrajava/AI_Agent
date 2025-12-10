package com.hercrentals.utils;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXParseException;

import com.hercrentals.exception.XMLExtractionException;

public class XMLParseHelper {
	private static final Logger log = LoggerFactory.getLogger(XMLParseHelper.class);

	private static final SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);

	public static void createSchemaAndValidateXML(byte[] byteXsdContent, byte[] byteXmlContent)
			throws XMLExtractionException {
		Schema schema = createSchema(byteXsdContent);
		validateXML(byteXmlContent, schema);
	}

	private static Schema createSchema(byte[] byteXsdContent) throws XMLExtractionException {
		try {
			return schemaFactory.newSchema(new StreamSource(new ByteArrayInputStream(byteXsdContent)));
		} catch (Exception e) {
			log.error("Exception occurred while creating schema from XSD: {}", e.getMessage());
			throw new XMLExtractionException("SCHEMA_CREATION_EXCEPTION occurred while creating schema from XSD",
					XMLExtractionException.ErrorCode.SCHEMA_CREATION_EXCEPTION, e);
		}
	}

	private static void validateXML(byte[] byteXmlContent, Schema schema) throws XMLExtractionException {
		try {
			Validator validator = schema.newValidator();
			InputStream xmlStream = new ByteArrayInputStream(byteXmlContent);
			validator.validate(new StreamSource(xmlStream));
			System.out.println("XML is valid against XSD");
		} catch (SAXParseException e) {
			log.error("SAXParseException occurred while validating XML against XSD: {}", e.getMessage());
			throw new XMLExtractionException(
					"XML_VALIDATION_EXCEPTION occurred while validating XML against XSD:: " + e.getMessage()
							+ "; lineNumber: " + e.getLineNumber()
							+ "; columnNumber: " + e.getColumnNumber(),
					XMLExtractionException.ErrorCode.XML_VALIDATION_EXCEPTION, e);
		} catch (Exception e) {
			log.error("Exception occurred while validating XML against XSD: {}", e.getMessage());
			throw new XMLExtractionException(
					"XML_VALIDATION_EXCEPTION occurred while validating XML against XSD:: " + e.getMessage(),
					XMLExtractionException.ErrorCode.XML_VALIDATION_EXCEPTION, e);
		}

	}

	public static Document parseXml(byte[] xmlBytes) throws Exception {
		ByteArrayInputStream inputStream = new ByteArrayInputStream(xmlBytes);
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setFeature("http://javax.xml.XMLConstants/feature/secure-processing", true);
		DocumentBuilder builder = factory.newDocumentBuilder();
		return builder.parse(new InputSource(inputStream));
	}

	public static List<Map<String, String>> parseMultipleTags(Document document, String tagName,
			Map<String, String> fieldMap) {
		List<Map<String, String>> result = new ArrayList<>();
		NodeList nodes = document.getElementsByTagName(tagName);

		for (int i = 0; i < nodes.getLength(); i++) {
			Element element = (Element) nodes.item(i);
			Map<String, String> entry = fieldMap.entrySet().stream()
					.collect(Collectors.toMap(
							Map.Entry::getKey,
							e -> getTagValue(element, e.getValue())));
			result.add(entry);
		}
		return result;
	}

	public static String getTagValue(Element parent, String tagName) {
		NodeList nodeList = parent.getElementsByTagName(tagName);
		if (nodeList != null && nodeList.getLength() > 0) {
			return nodeList.item(0).getTextContent();
		}
		return "";
	}

	public static String extractTagValue(Document doc, String tagName) throws XMLExtractionException {
		String value = getTagValue(doc.getDocumentElement(), tagName);
		if (value == null || value.trim().isEmpty()) {
			throw new XMLExtractionException(
					"Missing or empty value for tag: " + tagName,
					XMLExtractionException.ErrorCode.XML_TAG_MISSING_EXCEPTION);
		}
		return value.trim();
	}

	public static String extractTagValueWithEmpty(Document doc, String tagName) throws XMLExtractionException {
		String value = getTagValue(doc.getDocumentElement(), tagName);
		if (value == null) {
			throw new XMLExtractionException(
					"Tag is missing for: " + tagName,
					XMLExtractionException.ErrorCode.XML_TAG_MISSING_EXCEPTION);
		}
		return value.trim();
	}
}
