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
import audites.domain.Evidence

abstract class RepoDefault<T> {
	private static final SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(User).
		addAnnotatedClass(Department).addAnnotatedClass(Revision).addAnnotatedClass(Requirement).
		addAnnotatedClass(Evidence).addAnnotatedClass(Admin).addAnnotatedClass(Auditor).addAnnotatedClass(Audited).
		buildSessionFactory()

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def void addQueryBy(Criteria criteria, Object o) {}

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

	def List<T> searchByName(String s) {
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryBy(criteria, s)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		}
	}

	def void create(T t) {
		try {
			t.doBeforeCreate
			session.beginTransaction
//			session.save(t)
			session.saveOrUpdate(t)
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
			t.doBeforeCreate
			session.beginTransaction
			session.merge(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		}
	}

	def void doBeforeCreate(T t) {}
}
