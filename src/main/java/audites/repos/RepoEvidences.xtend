package audites.repos

import audites.repos.RepoDefault
import org.hibernate.Criteria
import audites.domain.Evidence
import org.hibernate.criterion.Restrictions
import audites.domain.Requirement

class RepoEvidences extends RepoDefault<Evidence> {

	static RepoEvidences instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoEvidences()
		}
		return instance
	}

	override getEntityType() {
		typeof(Evidence)

	}

	override addQueryByExample(Criteria criteria, Evidence ev) {
		if (ev.path != null) {
			criteria.add(Restrictions.eq("path", ev.path))
		}
	}

	def remove(Requirement req, Evidence ev) {
		req.deleteEvidence(ev)
		RepoRequirements.instance.update(req)
		super.remove(ev) // SI ESTA EN CASCADA LO VUELA DIRECTAMENTE HIBERNATE
	}

}
