package audites.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

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

	@Column
	String evidence

	@Column
	Boolean isCompleted = false

	new() {
		name = ""
		descripcion = ""
		comments = ""
		evidence = ""
	}

	new(String name, String description) {
		this.name = name
		this.descripcion = description
		comments = ""
		evidence = ""
	}

	def void setComments(String c) {
		comments = c
		ObservableUtils.firePropertyChanged(this, "comments")
	}

	def String getComments() {
		comments
	}

	def void setEvidence(String path) {
		evidence = path
		ObservableUtils.firePropertyChanged(this, "evidence")
	}

	def String getEvidence() {
		evidence
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

}
