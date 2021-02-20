package com.chaid.security

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.codehaus.groovy.util.HashCodeHelper
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@ToString(cache=true, includeNames=true, includePackage=false)
class MkpUserMkpRole implements Serializable {

	private static final long serialVersionUID = 1
	int id
	MkpUser mkpUser
	MkpRole mkpRole

	@Override
	boolean equals(other) {
		if (other instanceof MkpUserMkpRole) {
			other.mkpUserId == mkpUser?.id && other.mkpRoleId == mkpRole?.id
		}
	}

    @Override
	int hashCode() {
	    int hashCode = HashCodeHelper.initHash()
        if (mkpUser) {
            hashCode = HashCodeHelper.updateHash(hashCode, mkpUser.id)
		}
		if (mkpRole) {
		    hashCode = HashCodeHelper.updateHash(hashCode, mkpRole.id)
		}
		hashCode
	}

	static MkpUserMkpRole get(long mkpUserId, long mkpRoleId) {
		criteriaFor(mkpUserId, mkpRoleId).get()
	}

	static boolean exists(long mkpUserId, long mkpRoleId) {
		criteriaFor(mkpUserId, mkpRoleId).count()
	}

	private static DetachedCriteria criteriaFor(long mkpUserId, long mkpRoleId) {
		MkpUserMkpRole.where {
			mkpUser == MkpUser.load(mkpUserId) &&
			mkpRole == MkpRole.load(mkpRoleId)
		}
	}

	static MkpUserMkpRole create(MkpUser mkpUser, MkpRole mkpRole, boolean flush = false) {
		def instance = new MkpUserMkpRole(mkpUser: mkpUser, mkpRole: mkpRole)
		instance.save(flush: flush)
		instance
	}

	static boolean remove(MkpUser u, MkpRole r) {
		if (u != null && r != null) {
			MkpUserMkpRole.where { mkpUser == u && mkpRole == r }.deleteAll()
		}
	}

	static int removeAll(MkpUser u) {
		u == null ? 0 : MkpUserMkpRole.where { mkpUser == u }.deleteAll() as int
	}

	static int removeAll(MkpRole r) {
		r == null ? 0 : MkpUserMkpRole.where { mkpRole == r }.deleteAll() as int
	}

	static constraints = {
	    mkpUser nullable: false
		mkpRole nullable: false, validator: { MkpRole r, MkpUserMkpRole ur ->
			if (ur.mkpUser?.id) {
				if (MkpUserMkpRole.exists(ur.mkpUser.id, r.id)) {
				    return ['userRole.exists']
				}
			}
		}
	}

	static mapping = {
		table 'tb_user_role'
		id composite: ['mkpUser', 'mkpRole']
		version false
	}
}
