package audites.logger

import java.io.FileWriter
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.TimeZone

class Logger {
	protected static String defaultLogFile = "c:\\Users\\Esteban\\Desktop\\logs.txt"

	def static void write(String s) throws IOException {
		write(defaultLogFile, s);
	}

	def static void write(String f, String s) throws IOException {
		val tz = TimeZone.getTimeZone("EST"); // or PST, MID, etc ...
		val now = new Date();
		val df = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss ");
		df.setTimeZone(tz);
		val currentTime = df.format(now);

		val aWriter = new FileWriter(f, true);
		aWriter.write(currentTime + " " + s + "\r\n");
		aWriter.flush();
		aWriter.close();
	}

}
