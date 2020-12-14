package chaid

import admin.DictionaryItem

class AvailableMemberHouse {
    int id,version
    Household household
    MkChaid chaid
    DictionaryItem type_id
    java.sql.Timestamp arrival_time
    Integer member_no=0

    static constraints = {
        arrival_time nullable:true
        member_no nullable:true
    }


    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)

    }
}
