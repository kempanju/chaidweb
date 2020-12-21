package chaid

import admin.DictionaryItem
import admin.Street


class PreginantDetails {
    int id,version
    Household household
    MkChaid chaid
    Street village_id
    Date last_menstual,date_of_birth
    DictionaryItem danger_sign,visit_type,education_type,family_planning_type,child_group_no
    Integer child_no,age
    Boolean attended_clinic,prefer_family_planning,child_under_one,ever_used_any_family_planning
    String name,phone_number
    Integer pregnant_month
    java.sql.Timestamp created_at


    static constraints = {
        last_menstual nullable:true
        danger_sign nullable:true
        visit_type nullable:true
        education_type nullable:true
        family_planning_type nullable:true
        child_no nullable:true
        attended_clinic nullable:true
        child_under_one nullable:true
        prefer_family_planning nullable:true
        child_group_no nullable:true
        ever_used_any_family_planning nullable:true
        village_id nullable:true
        name nullable:true
        phone_number nullable:true,maxSize:50
        date_of_birth nullable:true
        age nullable:true
        created_at nullable:true
        pregnant_month formula:"(current_date -last_menstual::date)/30"

    }

    def beforeInsert(){
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)

    }
}
