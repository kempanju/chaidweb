package chaid

import admin.DictionaryItem

class PostDelivery {
    int version,id
    MkChaid chaid
    Date delivery_date
    DictionaryItem outcome_type,baby_condition,delivery_type,delivery_place,family_planning
    String facility_card_name
    DictionaryItem danger_sign
    Boolean provided_immunization,postnatal_clinic
    Integer under_five_no,child_age,child_age_month
    java.sql.Timestamp created_at

    static constraints = {
        provided_immunization nullable:true
        postnatal_clinic nullable:true
        danger_sign nullable:true
        facility_card_name nullable:true
        outcome_type nullable:true
        baby_condition nullable:true
        delivery_type nullable:true
        delivery_place nullable:true
        delivery_date nullable:true
        under_five_no nullable:true
        family_planning nullable:true
        child_age formula:"(current_date -delivery_date::date)/365"
        child_age_month formula:"(current_date -delivery_date::date)/30"
        created_at nullable: true
    }
    def beforeInsert(){
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)

    }
}
