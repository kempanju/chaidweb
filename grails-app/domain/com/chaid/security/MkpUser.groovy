package com.chaid.security

import admin.District
import admin.Street
import admin.Region

import chaid.Facility
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='username')
//@ToString(includes='username', includeNames=true, includePackage=false)
class MkpUser implements Serializable {

    private static final long serialVersionUID = 1

    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    String first_name,middle_name,last_name,email,phone_number,gender,full_name
    Street village_id;
    District district_id
    Region region
    Facility facility
    Set<MkpRole> getAuthorities() {
        (MkpUserMkpRole.findAllByMkpUser(this) as List<MkpUserMkpRole>)*.mkpRole as Set<MkpRole>
    }

    static constraints = {
        password nullable: false, blank: false, password: true
        username nullable: false, blank: false, unique: true
        middle_name nullable: true
        email nullable: true
        phone_number nullable: true
        gender nullable: true,maxSize: 20
        full_name formula: "CONCAT(first_name,' ',last_name)"
        village_id nullable:true
        district_id nullable:true
        facility nullable:true
        region nullable: true
    }

    static mapping = {
        table 'tb_user'
	    password column: '`password`'
        village_id column:'village_id'
        district_id column:'district_id'
    }
}
