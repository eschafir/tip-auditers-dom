package audites.domain

import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Dependencies
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

	@Column(length=500)
	String comments

	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	List<Evidence> evidences = newArrayList()

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

	@Dependencies("isCompleted")
	def String getRequirementStatus() {
		if (isCompleted) {
			"Completado"
		} else {
			"Pendiente"
		}
	}

	def void addEvidence(Evidence e) {
		if(!evidences.contains(e)) evidences.add(e)
		ObservableUtils.firePropertyChanged(this, "evidences")

	}

	def void changeRequirmentStatus() {
		isCompleted = !isCompleted
	}

	def deleteEvidence(Evidence e) {
		if(evidences.contains(e)) evidences.remove(e)
		ObservableUtils.firePropertyChanged(this, "evidences")
	}

}
