package audites.appModel

import audites.domain.Report
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import audites.repos.RepoReports
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class GenerateReportAppModel extends MainApplicationAppModel {

	Report report
	Revision revision
	Requirement requirementSelected
	String observations

	new() {
		super()
		report = new Report
		revision = new Revision
		requirementSelected = null
		observations = ""
	}

	new(User user, Revision revision) {
		super(user)
		report = new Report(revision)
		this.revision = revision
		requirementSelected = null
		observations = ""
	}

	def void setObservations(String obs) {
//		revision.report.observations = obs
		ObservableUtils.firePropertyChanged(this, "observations")

	}

	def String getObservations() {
		revision.report.observations
	}

	def saveOrUpdateReport() {
		report.observations = report.observations + observations
		RepoReports.instance.update(report)
	}

}
