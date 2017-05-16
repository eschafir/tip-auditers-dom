package audites.appModel

import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoReports
import audites.repos.RepoRevisions
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class GenerateOrEditReportAppModel extends MainApplicationAppModel {

	Revision revision

	new() {
		super()
		revision = new Revision
	}

	new(User user, Revision revision) {
		super(user)
		this.revision = revision
	}

	def saveOrUpdateReport() {
		RepoReports.instance.update(revision.report)
		RepoRevisions.instance.update(revision)
	}

}
