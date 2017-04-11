package audites.emailSender

import java.util.Properties
import javax.mail.Message
import javax.mail.Session
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMessage
import javax.mail.internet.MimeMultipart
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User

@Accessors
@Observable
abstract class EmailSender {

	def void sendEmail(User author, User reciever) {
		val remitent = "auditers.tip@gmail.com"
		val password = "Auditers123"

		var properties = new Properties()
		properties.put("mail.smtp.host", "smtp.gmail.com")
		properties.put("mail.smtp.starttls.enable", "true")
		properties.put("mail.smtp.port", "587")
		properties.put("mail.smtp.auth", "true")
		properties.put("mail.user", remitent)
		properties.put("mail.password", password)

		val session = Session.getInstance(properties, null)

		try {
			var mimeMessage = new MimeMessage(session)

			mimeMessage.setFrom(new InternetAddress(remitent, "AuditERS"))

			var internetAddresses = {
				new InternetAddress(reciever.email)
			}

			mimeMessage.setRecipient(Message.RecipientType.TO, internetAddresses)

			mimeMessage.setSubject(mailSubject())

			var mimeBodyPart = new MimeBodyPart()

			mimeBodyPart.setText(mailBody(author.name))

			var multipart = new MimeMultipart()
			multipart.addBodyPart(mimeBodyPart)

			mimeMessage.setContent(multipart)

			val transport = session.getTransport("smtp")
			transport.connect(remitent, password)
			transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients())
			transport.close()

		} catch (Exception ex) {
			ex.printStackTrace()
		}
		System.out.println("Correo enviado")
	}

	def abstract String mailSubject()

	def abstract String mailBody(String author)

}
