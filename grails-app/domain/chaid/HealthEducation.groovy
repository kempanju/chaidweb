package chaid

import admin.DictionaryItem

class HealthEducation {
    int id,version
    MkChaid chaid
    DictionaryItem type
    java.sql.Timestamp created_at

    static constraints = {
        created_at nullable:true
    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
