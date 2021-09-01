package materialize.view

class MonthlyReport {
    Integer day_sum
    java.sql.Timestamp txn_day

    static constraints = {
    }
    static mapping = {
        table 'mst_dayreports_view'
        version false
    }
}
