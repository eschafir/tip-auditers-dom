package audites.domain

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.FetchType
import javax.persistence.CascadeType

@Observable
@Accessors
@Entity
class Observation {

	@Id
	@GeneratedValue
	private Long id

	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Requirement requirement
	
	@Column(length=500)
	String comment

	new() {
		requirement = new Requirement
		comment = ""
	}

	new(Requirement req) {
		requirement = req
		comment = ""
	}
}
