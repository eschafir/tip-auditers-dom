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

	@ManyToOne(fetch=FetchType.LAZY)
	Report report = null

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
		requirements.filter[req|req.isCompleted].toList.size
	}

	def void setAverage(float avg) {
		average = avg
		ObservableUtils.firePropertyChanged(this, "average")
		ObservableUtils.firePropertyChanged(this, "isCompleted")
	}

	def float getAverage() {
		((completedRequirements * 1f ) / requirements.size)
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

	def Boolean getIsExpired() {
		endDate < new Date
	}

	def Boolean getIsDerivedToAuthor() {
		attendant == author
	}
}
