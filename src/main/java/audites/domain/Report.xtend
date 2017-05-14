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
class Report {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	new() {
		name = ""
	}

	new(Revision rev) {
		name = "Observaciones de " + rev.name
	}

}
