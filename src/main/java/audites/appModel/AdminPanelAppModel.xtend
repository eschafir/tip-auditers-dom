package audites.appModel

import audites.domain.User
import audites.repos.RepoUsers
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.Dependencies

@Observable
@Accessors
class AdminPanelAppModel extends MainApplicationAppModel {
	User toSearch = new User
	List<User> results
	User selectedUser

	new() {
		super()
		selectedUser = null
	}

	new(User user) {
		super(user)
		selectedUser = null
	}

	def createUser() {
	}

	def void setUserSearch(String user) {
		toSearch.username = user
		search
	}

	def String getUserSearch() {
		toSearch.username
	}

	def void search() {
		results = RepoUsers.instance.searchByExample(toSearch)
	}

	@Dependencies("selectedUser")
	def Boolean getHasUserSelected() {
		selectedUser != null
	}

}
