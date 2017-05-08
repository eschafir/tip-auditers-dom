package audites.domain

import java.util.Calendar
import java.util.Date
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Revision {

	@Id
	@GeneratedValue
	private Long id

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	User author

	@Column
	String name

	@Column(length=500)
	String description

	@Column
	Date initDate

	@Column
	Date endDate

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Department responsable

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Requirement> requirements = newArrayList()

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	User attendant

	@Column
	Boolean archived = false

	new() {
		author = new User
		name = ""
		description = ""
		initDate = Calendar.instance.time
		endDate = new Date
		responsable = new Department
		attendant = responsable.maxAuthority
	}

	def void setRequirements(List<Requirement> req) {
		requirements = req
		ObservableUtils.firePropertyChanged(this, "requirements")
	}

	def List<Requirement> getRequirements() {
		requirements
	}

	def addRequirement(Requirement r) {
		if (!requirements.contains(r)) {
			requirements.add(r)
		}
		ObservableUtils.firePropertyChanged(this, "requirements")
	}
	
	def removeRequirement(Requirement r) {
		if (requirements.contains(r)) {
			requirements.remove(r)
		}
		ObservableUtils.firePropertyChanged(this, "requirements")
	}

	def int completedRequirements() {
		var amount = 0
		for (Requirement requirement : requirements) {
			if(requirement.isCompleted) amount += 1
		}
		return amount
	}

	def void setAverage(float avg) {
		average = avg
		ObservableUtils.firePropertyChanged(this, "average")
		ObservableUtils.firePropertyChanged(this, "isCompleted")
	}

	def float getAverage() {
		((completedRequirements * 100) / requirements.size)
	}

	def void setAttendant(User u) {
		attendant = u
		ObservableUtils.firePropertyChanged(this, "isDerivedToAuthor")
	}

	def User getAttendant() {
		attendant
	}

	def Boolean getIsCompleted() {
		return (completedRequirements == requirements.size)
	}

	def Boolean getIsDerivedToAuthor() {
		attendant == author
	}
}
