package chaid

import java.sql.Date

class ChildFiveYears {
    int id,version
    MkChaid chaid
    Household household
    Integer child_no
    Boolean child_clinic,provided_immunization
    Date clinic_date
    java.sql.Timestamp created_at

    static constraints = {
        child_clinic nullable:true
        provided_immunization nullable:true
        child_no nullable:true
        clinic_date nullable:true
        created_at nullable:true

    }

    def beforeInsert() {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
    }
}
