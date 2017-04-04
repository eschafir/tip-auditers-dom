package audites.repos

import audites.domain.Admin
import audites.domain.Audited
import audites.domain.Auditor
import audites.domain.Department
import audites.domain.Requirement
import audites.domain.Revision
import audites.domain.User
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

abstract class RepoDefault<T> {
	private static final SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(User).
		addAnnotatedClass(Department).addAnnotatedClass(Revision).addAnnotatedClass(Requirement).
		addAnnotatedClass(Admin).addAnnotatedClass(Auditor).addAnnotatedClass(Audited).buildSessionFactory()

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	static Session session = sessionFactory.openSession

	def List<T> allInstances() {
		val result = session.createCriteria(entityType).list()
		return result
	}

	def List<T> searchByExample(T t) {
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		}
	}

	def void create(T t) {
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		}
	}

	def void remove(T t) {
		try {
			session.beginTransaction
			session.delete(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		}
	}

	def void update(T t) {
		try {
			session.beginTransaction
			session.merge(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		}
	}
}
