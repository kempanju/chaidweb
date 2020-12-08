package chaid

import admin.DictionaryItem
import admin.District
import admin.Street
import com.chaid.security.MkpUser

class MkChaid {
    int id,version
    Household household
    DictionaryItem visit_type,meeting_type,objective_type,relationship_status,interview_status
    java.sql.Timestamp arrival_time
    String respondent_name,respondent_gender,uniquecode
    Integer respondent_age,age_sick_person
    Boolean sick_person
    District distric
    Street street
    Double centroid_x=0,centroid_y=0
    MkpUser created_by
    static constraints = {
        visit_type nullable:true
        meeting_type nullable:true
        objective_type nullable:true
        objective_type nullable:true
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

    }
    static mapping = {
        created_by column: 'created_by'
    }

    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)

    }
}
