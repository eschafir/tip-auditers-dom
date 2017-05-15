package audites.repos

import audites.repos.RepoDefault
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions
import audites.domain.Report

class RepoReports extends RepoDefault<Report> {
	static RepoReports instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoReports()
		}
		return instance
	}

	override getEntityType() {
		typeof(Report)
	}

	override addQueryByExample(Criteria criteria, Report report) {
		if (report.name != null) {
			criteria.add(Restrictions.eq("name", report.name))
		}
	}
}
