package audites.activeDirectory

import java.util.Hashtable
import java.util.logging.Level
import java.util.logging.Logger
import javax.naming.Context
import javax.naming.NamingException
import javax.naming.directory.InitialDirContext
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ActiveDirectory {
	static final String LDAP_URL = "ldap://192.168.23.132:389"

	def boolean login(String username, String password) {
		var env = new Hashtable()
		env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory")
		env.put(Context.PROVIDER_URL, LDAP_URL)
		env.put(Context.SECURITY_AUTHENTICATION, "simple")
		env.put(Context.SECURITY_PRINCIPAL, username + "@PuenteHnos.local")
		env.put(Context.SECURITY_CREDENTIALS, password)

		try {
			new InitialDirContext(env)
			return true
		} catch (NamingException ex) {
			Logger.getLogger(ActiveDirectory.getName()).log(Level.SEVERE, null, ex)
		}
		return false
	}
}
