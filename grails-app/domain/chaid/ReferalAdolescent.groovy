package chaid
import admin.DictionaryItem

class ReferalAdolescent {
    int id,version
    MkChaid chaid
    Adolescent adolescent
    DictionaryItem type
    java.sql.Timestamp arrival_time

    static constraints = {
        arrival_time nullable:true
    }


    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)

    }
}
