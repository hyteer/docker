package docker.registry.web

import docker.registry.AccessControl
import docker.registry.Role
import docker.registry.RoleAccess
import docker.registry.UserRole
import grails.transaction.Transactional

@Transactional
class RoleController {
  def index() {
    def roles = Role.list()
    [roles: roles]
  }

  def show() {
    def role = Role.get(params.id)
    def users = UserRole.findAllByRole(role).user
    [role: role, users: users]
  }

  def deleteAcl() {
    def role = Role.get(params.roleId)
    def acl = AccessControl.get(params.id)
    log.info "Deleting acl=${acl} from role.id=${role}"
    def roleAccess = RoleAccess.findByRoleAndAcl(role, acl)
    roleAccess.delete()
    acl.delete()
    redirect action: 'show', id: params.roleId
  }

  def addAcl() {
    def role = Role.get(params.id)
    if (role.specialRole) {
      log.error "Can't add ACL to special role: ${role}"
      return
    }
    def acl = new AccessControl(params)
    acl.save()
    def roleAccess = new RoleAccess(role: role, acl: acl)
    roleAccess.save()
    redirect action: 'show', id: params.id
  }

  def add() {}

  def create() {
    def role = new Role(authority: params.role)
    log.info "Creating role ${role.authority}"
    role.save()
    if (role.hasErrors()) {
      log.warn "Error saving role: ${role.errors}"
      flash.errors = role.errors
      redirect action: 'add'
    } else {
      flash.message = 'role.created'
      redirect action: 'show', id: role.id
    }
  }

  def delete() {
    def role = Role.get(params.id)
    if (role.specialRole) {
      log.error "Can't delete special role: ${role}"
      return
    }
    log.info "Deleting role=${role}"
    UserRole.findByRole(role)*.delete()
    def roleAccess = RoleAccess.findAllByRole(role)
    def acls = roleAccess.acl
    log.info "Deleting acls: ${acls}"
    roleAccess*.delete()
    acls*.delete()
    role.delete()
    flash.role = role.authority
    flash.message = 'role.deleted'
    redirect action: 'index'
  }
}
