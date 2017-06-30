package audites.pdf

import audites.domain.Observation
import audites.domain.Revision
import com.itextpdf.text.Anchor
import com.itextpdf.text.BaseColor
import com.itextpdf.text.Chapter
import com.itextpdf.text.Document
import com.itextpdf.text.DocumentException
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfWriter
import java.io.FileOutputStream
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PdfExporter {
	String pdfPath
	Revision revision
	static Font headerFont = new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.BOLD)
	static Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD, BaseColor.DARK_GRAY)
	static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)

	new(String path, Revision rev) {
		pdfPath = path
		revision = rev
	}

	def createPDF() {
		try {
			var document = new Document()
			PdfWriter.getInstance(document, new FileOutputStream(pdfPath))
			document.open()
			addTitlePage(document)
			addContent(document)
			document.close()
		} catch (Exception e) {
			e.printStackTrace()
		}
	}

	def addTitlePage(Document document) throws DocumentException {

		var preface = new Paragraph()
		val img = Image.getInstance("C:/Users/eschafir/Desktop/auditers.png")
		img.alignment = Image.ALIGN_CENTER
		addEmptyLine(preface, 2)
		preface.add(img)
		addEmptyLine(preface, 5)
		preface.add(new Paragraph(revision.name.toUpperCase, PdfExporter.headerFont))
		addEmptyLine(preface, 1)
		preface.add(new Paragraph("Reporte de revisión", PdfExporter.subFont))
		addEmptyLine(preface, 3)
		preface.add(new Paragraph("Generado por: " + revision.author.name, smallBold))
		addEmptyLine(preface, 1)
		preface.add(new Paragraph("Fecha: " + new Date().toGMTString, smallBold))
		addEmptyLine(preface, 8)

		document.add(preface)
		document.newPage()

	}

	def addContent(Document document) throws DocumentException {
		var anchor = new Anchor("Observaciones", PdfExporter.headerFont)
		anchor.setName("Observaciones")

		var catPart = new Chapter(new Paragraph(anchor), 1)

		for (Observation obs : revision.report.observations) {
			if (obs.hasComment) {
				var obsName = new Paragraph(obs.requirement.name, subFont)
				var subCatPart = catPart.addSection(obsName)
				subCatPart.add(new Paragraph(obs.comment))
			}
		}
		document.add(catPart)
	}

	def addEmptyLine(Paragraph paragraph, int number) {
		for (var i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "))
		}
	}
}
