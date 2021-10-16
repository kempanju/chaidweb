package chaid

class Epidemic {
    int version,id
    String pandemic_name;
    Integer pandemic_total_count,pandemic_referral_no,pandemic_closed_referral
    static constraints = {
        pandemic_total_count nullable:true
        pandemic_referral_no nullable:true
        pandemic_closed_referral nullable:true
    }
}
