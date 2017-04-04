package audites.domain

import java.util.Calendar
import java.util.Date
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Revision {

	@Id
	@GeneratedValue
	private Long id

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.MERGE)
	User author

	@Column
	String name

	@Column(length=500)
	String description

	@Column
	Date initDate

	@Column
	Date endDate

	@ManyToOne(cascade=CascadeType.ALL)
	Department responsable

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Set<Requirement> requirements = newHashSet()

	new() {
		author = null
		name = ""
		description = ""
		initDate = Calendar.instance.time
		endDate = new Date
		responsable = null
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
