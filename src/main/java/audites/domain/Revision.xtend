package audites.domain

import audites.domain.States.RevisionState.RevisionState
import java.time.LocalDate
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.States.RequirementState.Completado
import audites.domain.States.RevisionState.Nueva

@Observable
@Accessors
@Entity
class Revision {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column
	LocalDate initDate

	@Column
	LocalDate endDate

	@Column
	User responsable

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	List<Requirement> requirements = newArrayList

	@Column
	RevisionState revisitonState

	new() {
		name = ""
		initDate = LocalDate.now
		endDate = LocalDate.MAX
		responsable = null
		revisitonState = new Nueva
	}

	def int completedRequirements() {
		var amount = 0
		for (Requirement r : requirements) {
			if (r.requirementState.class == Completado) {
				amount += 1
			}
		}
		return 0
	}

	def float average() {
		return 0
	}

}
