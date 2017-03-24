package audites.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Column

@Accessors
@Observable
@Entity
class Role {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	new() {
		name = ""
	}

}
