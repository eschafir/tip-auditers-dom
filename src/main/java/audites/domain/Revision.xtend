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
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
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

	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL, orphanRemoval=true)
	List<Requirement> requirements = newArrayList()

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	User attendant

	@Column
	Boolean archived = false

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Report report

	new() {
		author = new User
		name = ""
		description = ""
		initDate = Calendar.instance.time
		endDate = new Date
		responsable = new Department
		attendant = responsable.maxAuthority
		report = new Report
	}

	def void setName(String name) {
		this.name = name
		report.updateName(name)
		ObservableUtils.firePropertyChanged(this, "name")
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

	def float getAverage() {
		((completedRequirements * 1f ) / requirements.size)
	}

	def User getAttendant() {
		attendant
	}

	@Dependencies("average")
	def Boolean getIsCompleted() {
		return (completedRequirements == requirements.size)
	}

	def Boolean getIsExpired() {
		endDate < new Date
	}

	@Dependencies("attendant")
	def Boolean getIsDerivedToAuthor() {
		attendant == author
	}

	def Boolean getIsExpiredAndNotCompleted() {
		isExpired && !isCompleted
	}
}
