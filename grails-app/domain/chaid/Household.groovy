package chaid

import admin.District
import admin.Street

class Household {
    int version,id
    String name,number,full_name
    Boolean deleted
    Street village_id
    District district_id
    static constraints = {
        deleted nullable:true
        number nullable:true,maxSize:20
        full_name formula: "CONCAT(name,' ',number)"

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
