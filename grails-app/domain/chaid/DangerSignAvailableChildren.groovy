package chaid

import admin.DictionaryItem

class DangerSignAvailableChildren {
    int id,version
    DictionaryItem danger_type
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
