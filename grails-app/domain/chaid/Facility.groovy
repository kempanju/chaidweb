package chaid

import admin.District
import admin.Street

class Facility {

    int version,id
    String name,number
    Boolean deleted
    Street village_id
    District district_id
    static constraints = {
        deleted nullable:true
        number nullable:true,maxSize:20

    }

    def beforeInsert() {
        deleted=1
    }

    static mapping = {
        table 'tb_facility'
        village_id column: 'village_id'
        district_id column: 'district_id'
    }
}
