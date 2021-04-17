package chaid

import admin.DictionaryItem
import admin.District
import admin.Street

class Facility {

    int version,id
    String name,number,mobile_number,facilityType
    Boolean deleted
    Street village_id
    District district_id
    DictionaryItem type
    static constraints = {
        deleted nullable:true
        number nullable:true,maxSize:20,unique:true
        mobile_number nullable:true,maxSize:30
        village_id nullable:true
        type nullable:true
        facilityType nullable:true

    }

    def beforeInsert() {
        deleted=0
    }

    static mapping = {
        table 'tb_facility'
        village_id column: 'village_id'
        district_id column: 'district_id'
    }
}
