package com.hercrentals.utils;

import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.hercrentals.exception.HercSendMailException;
import com.hercrentals.exception.HercSendMailException.ErrorCode;

import jakarta.activation.DataHandler;
import jakarta.activation.DataSource;
import jakarta.activation.FileDataSource;
import jakarta.mail.BodyPart;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.util.ByteArrayDataSource;

@Component
public class SendMail {

	@Value("${herc.email.smtp.host}")
	private String host;

	@Value("${herc.email.smtp.port}")
	private String port;

	@Value("${herc.email.smtp.sslenabled}")
	private String sslEnabled;

	@Value("${herc.email.smtp.authEnabled}")
	private String authEnabled;

	@Value("${herc.email.smtp.userId}")
	private String userId;

	@Value("${herc.email.smtp.passwd}")
	private String passwd;

	@Value("${herc.email.from}")
	private String emailFrom;

	@Value("${herc.email.smtp.subject.text}")
	private String subjectText;

	@Value("${herc.email.smtp.message.text}")
	private String messageText;

	private static final String SMTP_HOST = "mail.smtp.host";
	private static final String SMTP_PORT = "mail.smtp.port";
	private static final String SMTP_SSL = "mail.smtp.ssl.enable";
	private static final String SMTP_AUTH = "mail.smtp.auth";

	public void sendEMail(List<String> toEmailList, List<String> ccEmailList, List<byte[]> attachments,
			String pdfFileName, String emailBody)
			throws HercSendMailException {
		Properties properties = System.getProperties();

		properties.put(SMTP_HOST, host);
		properties.put(SMTP_PORT, port);
		properties.put(SMTP_SSL, sslEnabled);
		properties.put(SMTP_AUTH, authEnabled);

		// Get the Session object.// and pass username and password
		Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userId, passwd);
			}
		});

		// Used to debug SMTP issues
		session.setDebug(false);

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(emailFrom));
			for (String email : toEmailList) {
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			}
			for (String cc_email : ccEmailList) {
				message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc_email));
			}
			Multipart finalMessage = addPdfAttachments(attachments, pdfFileName);
			message.setSubject(subjectText);

			// BodyPart htmlBodyPart = new MimeBodyPart();
			// htmlBodyPart.setContent(emailBody, "text/html; charset=utf-8");  // Ensuring proper HTML rendering
			// finalMessage.addBodyPart(htmlBodyPart);  // Add HTML content to the email
			// message.setContent(finalMessage);

			// Create the multipart container
			// Multipart multipart = new MimeMultipart();

			// HTML Body Part
			MimeBodyPart htmlBodyPart = new MimeBodyPart();
			String htmlContent = emailBody;
			htmlBodyPart.setContent(htmlContent, "text/html; charset=utf-8");
			finalMessage.addBodyPart(htmlBodyPart);
	
			// Attach the logo image
			MimeBodyPart imagePart = new MimeBodyPart();
			DataSource fds = new FileDataSource("fop_template/logos/hercYellowLogo.png"); // Update with actual path
			imagePart.setDataHandler(new DataHandler(fds));
			imagePart.setHeader("Content-ID", "<logo>");  // Must match 'cid:logo' in HTML
			imagePart.setDisposition(MimeBodyPart.INLINE); // Inline image
			finalMessage.addBodyPart(imagePart);
			message.setContent(finalMessage);

			// BodyPart textBodyPart = new MimeBodyPart();
			// // String emailBody = messageText + "\n" + "Please find the one time payment
			// // link below for your payment: \n"
			// // + paymentLink;
			// textBodyPart.setText(emailBody);
			// finalMessage.addBodyPart(textBodyPart);
			// message.setContent(finalMessage);
			System.out.println("sending...");
			// Send message
			Transport.send(message);
			System.out.println("Sent message successfully....");
		} catch (MessagingException mex) {
			mex.printStackTrace();
			throw new HercSendMailException("Exception occured while sending message::" + mex.getMessage(),
					ErrorCode.MESSAGING_EXCEPTION, mex);
		}

	}

	private Multipart addPdfAttachments(List<byte[]> pdfByteArrays, String pdfFileName) throws MessagingException {
		Multipart multipart = new MimeMultipart();

		for (byte[] pdfBytes : pdfByteArrays) {
			try {
				BodyPart attachmentBodyPart = new MimeBodyPart();

				// Create a DataSource from the byte array
				DataSource source = new ByteArrayDataSource(pdfBytes, "application/pdf");

				// Set the DataHandler to the attachment BodyPart
				attachmentBodyPart.setDataHandler(new DataHandler(source));

				// Set the file name (optional)
				attachmentBodyPart.setFileName(pdfFileName);

				// Add the attachment BodyPart to the Multipart
				multipart.addBodyPart(attachmentBodyPart);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return multipart;
	}
}