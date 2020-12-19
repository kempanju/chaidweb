package chaid

import admin.DictionaryItem

class HouseholdDetails {
    int id,version
    Household household
    DictionaryItem detailsType
    Integer member_no=0
    java.sql.Timestamp created_at

    static constraints = {
        member_no nullable:true
        created_at nullable:true

    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
