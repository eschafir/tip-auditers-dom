package audites.repos

import org.hibernate.Criteria
import audites.domain.Department
import org.hibernate.criterion.Restrictions

class RepoDepartments extends RepoDefault<Department> {

	static RepoDepartments instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoDepartments()
		}
		return instance
	}

	override getEntityType() {
		typeof(Department)
	}

	override addQueryByExample(Criteria criteria, Department department) {
		if (department.name != null) {
			criteria.add(Restrictions.eq("name", department.name))
		}
	}

}
