package chaid

import admin.DictionaryItem
import admin.District
import admin.Street
import com.chaid.security.MkpUser


class MkChaid {
    int id,version
    DictionaryItem visit_type,meeting_type,objective_type,relationship_status,interview_status,living_with_household
    java.sql.Timestamp arrival_time
    String respondent_name,respondent_gender,uniquecode,reg_no,sick_person_name
    Integer respondent_age,total_members,age_sick_person,emergence_status,members_male=0,members_female=0
    Boolean sick_person,care_giver,deleted,repeated
    District distric
    Street street
    Double centroid_x=0,centroid_y=0,accuracy=0
    MkpUser created_by
    Facility facility
    String message,app_logs,pandemic_name
    Integer pandemic_total_count,pandemic_referral_no,pandemic_closed_referral

    static belongsTo = [household: Household]

    static constraints = {
        visit_type nullable:true
        meeting_type nullable:true
        objective_type nullable:true
        objective_type nullable:true
        household nullable:true
        repeated nullable: true
        relationship_status nullable:true
        interview_status nullable:true
        arrival_time nullable:true
        respondent_name nullable:true
        respondent_gender nullable:true
        respondent_age nullable:true
        age_sick_person nullable:true
        sick_person nullable:true
        street nullable:true
        uniquecode nullable:true,maxSize:50,unique:true
        centroid_x nullable:true
        centroid_y nullable:true
        created_by nullable:true
        accuracy nullable:true
        care_giver nullable:true
        reg_no nullable:true
        emergence_status nullable:true
        facility nullable:true
        message nullable:true
        app_logs nullable:true
        deleted nullable: true
        sick_person_name nullable: true
        living_with_household nullable:true
        members_male nullable:true
        members_female nullable:true
        total_members formula:"(members_male+members_female)"
        pandemic_name nullable:true

        pandemic_total_count nullable:true
        pandemic_referral_no nullable:true
        pandemic_closed_referral nullable:true


    }
    static mapping = {
        created_by column: 'created_by'
        message type: "text"
        app_logs type:"text"
    }

    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)
        emergence_status=0
        deleted=0

    }
}
