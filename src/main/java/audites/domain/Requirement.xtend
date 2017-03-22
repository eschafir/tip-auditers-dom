package audites.domain

import audites.domain.States.RequirementState.RequirementState
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.domain.States.RequirementState.Pendiente

@Observable
@Accessors
@Entity
class Requirement {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column
	String descripcion

	@Column
	RequirementState requirementState = new Pendiente

	/**
	 * Agregar propiedad de adjunto
	 */
	new() {
		name = ""
		descripcion = ""
	}

	new(String name, String description) {
		this.name = name
		this.descripcion = description
	}

}
