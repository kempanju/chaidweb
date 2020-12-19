package chaid

import admin.DictionaryItem

class ImmunizationAvailableChildren {
    int id,version
    DictionaryItem immunization_type
    java.sql.Timestamp created_at
    AvailableMemberHouse availableMemberHouse
    CategoryAvailableChildren categoryAvailableChildren
    static constraints = {
        created_at nullable:true
    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
