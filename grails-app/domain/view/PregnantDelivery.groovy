package view

class PregnantDelivery {
    int id,version
    Date last_menstual
    Integer diff_days,age
    static constraints = {
    }
    static mapping = {
        table 'view_delivery_this_month'
        version false
    }
}
