package audites.appModel

import audites.domain.Department
import audites.domain.Role
import audites.domain.User
import audites.repos.RepoDepartments
import audites.repos.RepoRoles
import audites.repos.RepoUsers
import java.util.List
import org.apache.commons.codec.digest.DigestUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class NewUserAppModel extends MainApplicationAppModel {

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

	def getUserDepartments() {
		user.departments
	}

	def getUserRoles() {
		user.roles
	}

	def addDepartment() {
		user.addDepartment(selectorDepartment)
		RepoUsers.instance.update(user)
		ObservableUtils.firePropertyChanged(this, "userDepartments")
	}

	def removeDepartment() {
		user.removeDepartment(selectedDepartment)
		RepoUsers.instance.update(user)
		ObservableUtils.firePropertyChanged(this, "userDepartments")
	}

	def addRole() {
		user.addRole(selectorRole)
		RepoUsers.instance.update(user)
		ObservableUtils.firePropertyChanged(this, "userRoles")
	}

	def removeRole() {
		user.removeRole(selectedRole)
		RepoUsers.instance.update(user)
		ObservableUtils.firePropertyChanged(this, "userRoles")
	}

	def void createUser() {
		user.password = passwordIngresed
		RepoUsers.instance.create(user)
		RepoUsers.instance.update(user)
	}

	def save() {
		validateUserInfo
		user.password = DigestUtils.sha256Hex(passwordIngresed)
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

	@Dependencies("selectorDepartment")
	def Boolean getIsDepartmentIngresed() {
		selectorDepartment != null
	}

	@Dependencies("selectedDepartment")
	def Boolean getIsDepartmentSelected() {
		selectedDepartment != null
	}

	@Dependencies("selectorRole")
	def Boolean getIsRoleIngresed() {
		selectorRole != null
	}

	@Dependencies("selectedRole")
	def Boolean getIsRoleSelected() {
		selectedRole != null
	}

	def cancelCreation() {
		if(!user.departments.empty) user.departments.removeAll
		if(!user.roles.empty) user.roles.removeAll
		RepoUsers.instance.remove(user)
	}
}
