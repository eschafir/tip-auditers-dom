package audites.domain;

import audites.domain.Department;
import audites.domain.Revision;
import audites.domain.Role;
import com.google.common.base.Objects;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Pure;
import org.uqbar.commons.utils.Observable;

@Observable
@Accessors
@Entity
@SuppressWarnings("all")
public class User {
  @Id
  @GeneratedValue
  private Long id;
  
  @Column
  private String name;
  
  @Column
  private String username;
  
  @Column
  private String password;
  
  @Column
  private String email;
  
  @ManyToMany(fetch = FetchType.LAZY)
  private List<Department> departments = CollectionLiterals.<Department>newArrayList();
  
  @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
  private List<Role> roles = CollectionLiterals.<Role>newArrayList();
  
  @ManyToMany(fetch = FetchType.LAZY)
  private List<Revision> revisions = CollectionLiterals.<Revision>newArrayList();
  
  public User() {
    this.name = "";
    this.username = "";
    this.password = "";
    this.email = "";
  }
  
  public User(final String n, final String u, final String p, final String m) {
    this.name = n;
    this.username = u;
    this.password = p;
    this.email = m;
  }
  
  public void addDepartment(final Department dep) {
    boolean _contains = this.departments.contains(dep);
    boolean _not = (!_contains);
    if (_not) {
      this.departments.add(dep);
    }
  }
  
  public void addRevision(final Revision rev) {
    boolean _contains = this.revisions.contains(rev);
    boolean _not = (!_contains);
    if (_not) {
      this.revisions.add(rev);
    }
  }
  
  public List<Revision> getRevisions() {
    for (final Department d : this.departments) {
      Set<Revision> _revisions = d.getRevisions();
      for (final Revision r : _revisions) {
        boolean _contains = this.revisions.contains(r);
        boolean _not = (!_contains);
        if (_not) {
          this.revisions.add(r);
        }
      }
    }
    return this.revisions;
  }
  
  public Boolean maximumResponsable(final Department dep) {
    User _maxAuthority = dep.getMaxAuthority();
    return Boolean.valueOf(Objects.equal(_maxAuthority, this));
  }
  
  @Pure
  public Long getId() {
    return this.id;
  }
  
  public void setId(final Long id) {
    this.id = id;
  }
  
  @Pure
  public String getName() {
    return this.name;
  }
  
  public void setName(final String name) {
    this.name = name;
  }
  
  @Pure
  public String getUsername() {
    return this.username;
  }
  
  public void setUsername(final String username) {
    this.username = username;
  }
  
  @Pure
  public String getPassword() {
    return this.password;
  }
  
  public void setPassword(final String password) {
    this.password = password;
  }
  
  @Pure
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(final String email) {
    this.email = email;
  }
  
  @Pure
  public List<Department> getDepartments() {
    return this.departments;
  }
  
  public void setDepartments(final List<Department> departments) {
    this.departments = departments;
  }
  
  @Pure
  public List<Role> getRoles() {
    return this.roles;
  }
  
  public void setRoles(final List<Role> roles) {
    this.roles = roles;
  }
  
  public void setRevisions(final List<Revision> revisions) {
    this.revisions = revisions;
  }
}
