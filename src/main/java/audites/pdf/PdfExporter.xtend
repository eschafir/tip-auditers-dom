package audites.pdf

import com.itextpdf.text.BaseColor
import com.itextpdf.text.Font
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PdfExporter {
	String pdfPath
	static Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
	static Font redFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.RED);
	static Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
	static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
}
