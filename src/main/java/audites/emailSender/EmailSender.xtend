package audites.emailSender

import java.util.Properties
import javax.mail.Message
import javax.mail.Session
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMessage
import javax.mail.internet.MimeMultipart

class EmailSender {

	def static void sendMail() {
		// El correo gmail de envío
		val correoEnvia = "auditers.tip@gmail.com"
		val claveCorreo = "Auditers123"

		// La configuración para enviar correo
		var properties = new Properties()
		properties.put("mail.smtp.host", "smtp.gmail.com")
		properties.put("mail.smtp.starttls.enable", "true")
		properties.put("mail.smtp.port", "587")
		properties.put("mail.smtp.auth", "true")
		properties.put("mail.user", correoEnvia)
		properties.put("mail.password", claveCorreo)

		// Obtener la sesion
		val session = Session.getInstance(properties, null)

		try {
			// Crear el cuerpo del mensaje
			var mimeMessage = new MimeMessage(session)

			// Agregar quien envía el correo
			mimeMessage.setFrom(new InternetAddress(correoEnvia, "AuditERS"))

			// Los destinatarios
			var internetAddresses = {
				new InternetAddress("esteban.schafir@gmail.com")
			}

			// Agregar los destinatarios al mensaje
			mimeMessage.setRecipient(Message.RecipientType.TO, internetAddresses)

			// Agregar el asunto al correo
			mimeMessage.setSubject("Prueba de correo AuditERS")

			// Creo la parte del mensaje
			var mimeBodyPart = new MimeBodyPart();
			mimeBodyPart.setText("Prueba de correo AuditERS");

			// Crear el multipart para agregar la parte del mensaje anterior
			var multipart = new MimeMultipart();
			multipart.addBodyPart(mimeBodyPart);

			// Agregar el multipart al cuerpo del mensaje
			mimeMessage.setContent(multipart);

			// Enviar el mensaje
			val transport = session.getTransport("smtp");
			transport.connect(correoEnvia, claveCorreo);
			transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
			transport.close();

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		System.out.println("Correo enviado");
	}
	
	def static void main(String[] args) {
		EmailSender.sendMail
	}

}
