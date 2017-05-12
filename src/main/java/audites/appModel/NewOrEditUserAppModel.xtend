package audites.appModel

import audites.domain.Department
import audites.domain.Role
import audites.domain.User
import audites.repos.RepoDepartments
import audites.repos.RepoRoles
import audites.repos.RepoUsers
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NewOrEditUserAppModel extends MainApplicationAppModel {

	User user
	List<Department> departments
	List<Role> roles
	Department selectorDepartment
	Department selectedDepartment
	Role selectedRole
	Role selectorRole
	String passwordIngresed

	new() {
		super()
		this.user = new User
		departments = RepoDepartments.instance.allInstances
		roles = RepoRoles.instance.allInstances
		selectorDepartment = null
		selectedDepartment = null
		selectedRole = null
		selectorRole = null
		passwordIngresed = ""
	}

	new(User user) {
		super(user)
		this.user = new User
		departments = RepoDepartments.instance.allInstances
		roles = RepoRoles.instance.allInstances
		selectorDepartment = null
		selectedDepartment = null
		selectedRole = null
		selectorRole = null
		passwordIngresed = ""
	}

	new(User userLoged, User toEdit) {
		super(userLoged)
		this.user = toEdit
		departments = RepoDepartments.instance.allInstances
		roles = RepoRoles.instance.allInstances
		selectorDepartment = null
		selectedDepartment = null
		selectedRole = null
		selectorRole = null
		passwordIngresed = ""
	}

	def addDepartment() {
		user.addDepartment(selectorDepartment)
		RepoUsers.instance.update(user)
	}

	def removeDepartment() {
		user.removeDepartment(selectedDepartment)
		RepoUsers.instance.update(user)
	}

	def void createUser() {
		user.password = ""
		RepoUsers.instance.create(user)
		user.password = passwordIngresed
		RepoUsers.instance.update(user)
	}

	def saveOrUpdate() {
		validateUserInfo
		user.password = passwordIngresed
		RepoUsers.instance.update(user)
	}

	def validateUserInfo() {
		if (user.username == "") {
			throw new UserException("Debe ingresar un UserID.")
		}
		if (user.name == "") {
			throw new UserException("Debe ingresar el nombre del usuario.")
		}
		if (user.email == "") {
			throw new UserException("Debe ingresar el email del usuario.")
		}
		if (user.departments.empty) {
			throw new UserException("Debe ingresar al menos un Departamento.")
		}
	}

}
