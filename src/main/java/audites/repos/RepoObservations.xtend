package audites.repos

import audites.repos.RepoDefault
import audites.domain.Observation
import org.hibernate.Criteria

class RepoObservations extends RepoDefault<Observation> {

	static RepoObservations instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoObservations()
		}
		return instance
	}

	override getEntityType() {
		typeof(Observation)
	}

	override addQueryByExample(Criteria criteria, Observation t) {
	}

}
