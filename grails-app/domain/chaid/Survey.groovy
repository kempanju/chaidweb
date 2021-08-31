package chaid

import admin.Dictionary

class Survey {
    int id,version
    MkChaid chaid
    Dictionary type
    Integer survey_no
    java.sql.Timestamp arrival_time

    static constraints = {
        arrival_time nullable:true
    }
    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)

    }
}
