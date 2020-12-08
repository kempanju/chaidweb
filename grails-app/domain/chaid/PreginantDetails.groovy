package chaid

import admin.DictionaryItem
import admin.Street

import java.sql.Date

class PreginantDetails {
    int id,version
    Household household
    MkChaid chaid
    Street village_id
    Date last_menstual
    DictionaryItem danger_sign,visit_type,education_type,family_planning_type,child_group_no
    Integer child_no
    Boolean attended_clinic,prefer_family_planning,child_under_one,ever_used_any_family_planning



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

    }
}
