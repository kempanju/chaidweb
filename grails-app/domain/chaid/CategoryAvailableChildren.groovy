package chaid

import admin.DictionaryItem

class CategoryAvailableChildren {
    int id,version
    DictionaryItem categoryType
    AvailableMemberHouse availableMemberHouse
    Integer member_no
    Boolean taken_baby_to_clinic,baby_provided_immunization,is_referrals
    java.sql.Timestamp created_at

    static constraints = {
        created_at nullable:true
        is_referrals nullable:true
    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
        is_referrals=0
    }
}
