package chaid

class Adolescent {
    int id,version
    MkChaid chaid
    String  name,gender,phone_number,lower_school,higher_school,health_center
    Boolean sexual_abused
    String sexual_abused_user,referrals

    java.sql.Timestamp arrival_time
    Integer age

    static constraints = {
        arrival_time nullable:true
        sexual_abused nullable:true
        health_center nullable:true
        higher_school nullable:true
        lower_school nullable:true
        phone_number nullable:true
        gender nullable:true
        age nullable:true
        sexual_abused_user nullable:true
        referrals nullable:false
    }


    def beforeInsert(){
        def current_time = Calendar.instance
        arrival_time = new java.sql.Timestamp(current_time.time.time)

    }
}
