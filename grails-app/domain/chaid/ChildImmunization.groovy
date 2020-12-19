package chaid

import admin.DictionaryItem

class ChildImmunization {
    int id,version
    PostDelivery postDelivery
    MkChaid chaid
    DictionaryItem immunization_type
    java.sql.Timestamp created_at

    static constraints = {
        created_at nullable:true
    }
    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
