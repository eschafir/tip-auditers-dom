package audites.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Column
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorValue

@Accessors
@Observable
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoRol", discriminatorType=DiscriminatorType.INTEGER)
abstract class Role {

	@Id
	@GeneratedValue
	private Long id

	@Column
	String name

	new() {
		name = ""
	}

}

@Accessors
@Entity
@DiscriminatorValue("1")
class Admin extends Role {

	new() {
		name = "Administrator"
	}

}

@Accessors
@Entity
@DiscriminatorValue("2")
class Auditor extends Role {

	new() {
		name = "Auditor"
	}

}

@Accessors
@Entity
@DiscriminatorValue("3")
class Audited extends Role {

	new() {
		name = "Audited"
	}

}
