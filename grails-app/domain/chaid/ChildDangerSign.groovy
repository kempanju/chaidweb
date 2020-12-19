package chaid

import admin.DictionaryItem

class ChildDangerSign {
    int id,version
    ChildFiveYears childFiveYears
    DictionaryItem sign_type
    java.sql.Timestamp created_at

    static constraints = {
        created_at nullable:true
    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
