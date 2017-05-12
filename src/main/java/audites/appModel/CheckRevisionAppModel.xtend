package audites.appModel

import audites.domain.Evidence
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class CheckRevisionAppModel extends NewRevisionAppModel {

	new(Revision revision, User user) {
		super(revision, user)
	}

	new(Requirement requirement) {
		super()
		selectedRequirement = requirement
	}

	def List<Evidence> getEvidencesOfRequirementSelected() {
		selectedRequirement.evidences
	}

	override void setSelectedRequirement(Requirement req) {
		super.selectedRequirement = req
		ObservableUtils.firePropertyChanged(this, "hasEvidence")
	}

	override Requirement getSelectedRequirement() {
		super.selectedRequirement
	}

	def Boolean getHasEvidence() {
		!selectedRequirement.evidences.empty
	}

}
