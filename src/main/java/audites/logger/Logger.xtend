package audites.logger

import audites.domain.User
import java.io.FileWriter
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.TimeZone
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Logger {

	User author

	new() {
		author = new User
	}

	new(User author) {
		this.author = author
	}

	protected static String defaultLogFile = "c:\\Users\\Esteban\\Desktop\\logs.txt"

	def void write() throws IOException {
		write(defaultLogFile, loggerType())
	}

	def abstract String loggerType()

	def void write(String f, String s) throws IOException {
		val tz = TimeZone.getTimeZone("EST") // or PST, MID, etc ...
		val now = new Date()
		val df = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss ")
		df.setTimeZone(tz)
		val currentTime = df.format(now)

		val aWriter = new FileWriter(f, true)
		aWriter.write(currentTime + " " + s + "\r\n")
		aWriter.flush()
		aWriter.close()
	}
}


