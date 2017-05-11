package audites.appModel

import audites.domain.Department
import audites.domain.User
import audites.repos.RepoDepartments
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import audites.repos.RepoUsers

@Observable
@Accessors
class NewOrEditUserAppModel extends MainApplicationAppModel {

	User user
	List<Department> departments
	Department selectorDepartment
	Department selectedDepartment
	String passwordIngresed

	new() {
		super()
		this.user = new User
		departments = RepoDepartments.instance.allInstances
		selectorDepartment = null
		selectedDepartment = null
		passwordIngresed = ""
	}

	new(User user) {
		super(user)
		this.user = new User
		departments = RepoDepartments.instance.allInstances
		selectorDepartment = null
		selectedDepartment = null
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

}
