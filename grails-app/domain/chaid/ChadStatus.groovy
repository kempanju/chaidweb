package chaid

import admin.DictionaryItem
import com.chaid.security.MkpUser

class ChadStatus {
    int id,version
    MkChaid chaid
    Boolean deleted
    DictionaryItem status
    java.sql.Timestamp created_at
    String comment
    MkpUser createdBy

    static constraints = {
        created_at nullable:true
        deleted nullable:true
        comment nullable:true
        createdBy nullable:true
    }

    def beforeInsert(){
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
        deleted=0

    }
}
