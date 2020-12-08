package admin

import chaid.Facility
import com.chaid.security.MkpUser

class SystemLogs {
    int id,version
    DictionaryItem log_type
    java.sql.Timestamp created_at,sending_time
    String message
    String msg_status,unique_id
    Integer sending_status
    Boolean user_visible
    static belongsTo = [user_id: MkpUser]
    Facility facility

    static constraints = {
        created_at nullable: true
        message nullable: true
        msg_status nullable: true
        unique_id nullable: true
        sending_status nullable: true,maxSize:2
        sending_time nullable: true
        user_visible nullable: true
        facility nullable:true
    }

    static mapping = {
        table 'db_system_logs'
        log_type column: 'log_type'
        user_id column: 'user_id'
    }

    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
        msg_status="NONE"
    }
}
