package materialize.view

class YearReports {

    Integer monthly_sum
    java.sql.Timestamp txn_month

    static constraints = {
    }
    static mapping = {
        table 'mst_monthlyreports_view'
        version false
    }
}
