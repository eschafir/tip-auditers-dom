package audites.domain

import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
@Accessors
@Entity
class User {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	@Column
	String password

	@Column
	String email

	//Role role

	new() {
		name = null
		password = null
		email = null
		//role = null
	}
}
