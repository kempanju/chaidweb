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
    Integer male_no=0,female_no=0
    int total_members
    static constraints = {
        deleted nullable:true
        number nullable:true,maxSize:20
        full_name formula: "CONCAT(name,' ',number)"
        male_no nullable:true
        female_no nullable:true
        street nullable:true
        total_members formula:"(male_no+female_no)"
    }

    def beforeInsert() {
        deleted=0
    }

    static mapping = {
        table 'tb_household'
        village_id column: 'village_id'
        district_id column: 'district_id'

    }
}
