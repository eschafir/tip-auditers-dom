package audites.domain

import java.time.LocalDate
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

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

	@ManyToOne(cascade=CascadeType.ALL)
	Department responsable

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Requirement> requirements

	new() {
		name = ""
		initDate = LocalDate.now
		endDate = LocalDate.MAX
		responsable = new Department
		requirements = newHashSet()
	}

	def addRequirement(Requirement r) {
		if (!requirements.contains(r)) {
			requirements.add(r)
		}
	}

	def int completedRequirements() {
		var amount = 0
		for (Requirement r : requirements) {
			//
		}
		return amount
	}

	def float average() {
		return ((completedRequirements * 100) / requirements.size)
	}

	def Boolean isCompleted() {
		return (completedRequirements == requirements.size)
	}

}
