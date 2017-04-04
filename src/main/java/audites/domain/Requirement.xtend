package audites.domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
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
	Boolean isCompleted = false

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
