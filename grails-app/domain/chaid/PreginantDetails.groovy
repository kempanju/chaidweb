package chaid

import admin.DictionaryItem
import admin.Street


class PreginantDetails {
    int id,version
    Household household
    MkChaid chaid
    Street village_id
    Date last_menstual,date_of_birth,clinic_first_date,clinic_second_date,clinic_third_date,clinic_fourth_date
    DictionaryItem danger_sign,visit_type,education_type,family_planning_type,child_group_no
    Integer child_no,age
    Boolean attended_clinic,prefer_family_planning,child_under_one,ever_used_any_family_planning,is_referrals
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
        is_referrals nullable:true
        clinic_first_date nullable:true
        clinic_second_date nullable:true
        clinic_third_date nullable:true
        clinic_fourth_date nullable:true
    }

    def beforeInsert(){
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)
        is_referrals=0

    }
}
