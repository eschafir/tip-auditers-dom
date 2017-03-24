package audites.repos

import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration
import audites.domain.User
import audites.domain.Department
import audites.domain.Revision
import audites.domain.Requirement

abstract class RepoDefault<T> {
	private static final SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(User).
		addAnnotatedClass(Department).addAnnotatedClass(Revision).addAnnotatedClass(Requirement).buildSessionFactory()

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def openSession() {
		sessionFactory.openSession
	}

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			// return session.createCriteria(getEntityType).list()
			val result = session.createCriteria(entityType).list()
			return result
		} finally {
			session.close
		}
	}

	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
}
