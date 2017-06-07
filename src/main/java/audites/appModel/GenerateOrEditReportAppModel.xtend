package audites.appModel

import audites.domain.Report
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoRevisions
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class GenerateOrEditReportAppModel extends MainApplicationAppModel {

	Revision revision
	Report report

	new() {
		super()
		revision = new Revision
	}

	new(User user, Revision revision) {
		super(user)
		this.revision = revision
		report = new Report(revision)
	}

	def saveOrUpdateReport() {
		if (revision.report == null) {
			revision.report = report
		}
		RepoRevisions.instance.update(revision)
	}

}
