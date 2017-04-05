package audites.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable
import javax.persistence.ManyToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType
import java.util.Set

@Observable
@Accessors
@Entity
class Requirement {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column(length=500)
	String descripcion

	@Column
	String comments

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Set<Evidence> evidences = newHashSet()

	@Column
	Boolean isCompleted = false

	new() {
		name = ""
		descripcion = ""
		comments = ""
	}

	new(String name, String description) {
		this.name = name
		this.descripcion = description
		comments = ""
	}

	def void setComments(String c) {
		comments = c
		ObservableUtils.firePropertyChanged(this, "comments")
	}

	def String getComments() {
		comments
	}

	def void setIsCompleted(Boolean b) {
		isCompleted = b
		ObservableUtils.firePropertyChanged(this, "requirementStatus")
	}

	def String getRequirementStatus() {
		if (isCompleted) {
			"Completado"
		} else {
			"Pendiente"
		}
	}

	def void addEvidence(Evidence e) {
		if(!evidences.contains(e)) evidences.add(e)
	}

}
