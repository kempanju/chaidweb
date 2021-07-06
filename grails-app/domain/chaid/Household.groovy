package chaid

import admin.District
import admin.Street
import admin.SubStreet

class Household {
    int version,id
    String name,number,full_name
    Boolean deleted
    Street village_id
    SubStreet street
    District district_id
    Facility facility
    Integer male_no=0,female_no=0
    java.sql.Timestamp created_at
    int total_members
    static hasMany = [subChaids:MkChaid]

    static constraints = {
        deleted nullable:true
        number nullable:true,maxSize:20
        full_name formula: "CONCAT(name,' ',number)"
        male_no nullable:true
        female_no nullable:true
        street nullable:true
        total_members formula:"(male_no+female_no)"
        created_at nullable:true
        facility nullable:true
    }

    def beforeInsert() {
        deleted=0
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }

    static mapping = {
        table 'tb_household'
        village_id column: 'village_id'
        district_id column: 'district_id'

    }
}
