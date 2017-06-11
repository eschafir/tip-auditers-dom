package audites.appModel

import audites.domain.Report
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoRevisions
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.pdf.PdfExporter

@Observable
@Accessors
class GenerateOrEditReportAppModel extends MainApplicationAppModel {

	Revision revision
	String filePath

	new() {
		super()
		revision = new Revision
		filePath = ""
	}

	new(User user, Revision revision) {
		super(user)
		this.revision = revision
		filePath = ""
	}

	def void setFilePath(String s) {
		filePath = s
		new PdfExporter(filePath, revision).createPDF
	}

	def saveOrUpdateReport() {
		RepoRevisions.instance.update(revision)
	}

	def createReport() {
		revision.report = new Report(revision)
		RepoRevisions.instance.update(revision)
	}

	def getEditImage() {
		"edit.png"
	}

	def void setEditImage(String p) {
		editImage = p
	}
}
