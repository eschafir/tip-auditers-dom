package audites.appModel

import audites.domain.Observation
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.User
import audites.repos.RepoObservations
import audites.domain.Revision

@Observable
@Accessors
class EditObservationAppModel extends MainApplicationAppModel {

	Revision revision
	Observation observation
	String comments

	new() {
		super()
		revision = new Revision
		observation = new Observation
		comments = ""
	}

	new(Observation obs, User user, Revision rev) {
		super(user)
		revision = rev
		observation = obs
		comments = obs.comment
	}

	def saveComment() {
		observation.comment = comments
		RepoObservations.instance.update(observation)
	}

}
