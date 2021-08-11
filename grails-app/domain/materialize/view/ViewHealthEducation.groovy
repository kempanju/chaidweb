package materialize.view
import admin.DictionaryItem
import chaid.MkChaid

class ViewHealthEducation {
    Integer member_no
    DictionaryItem category
    DictionaryItem education_type
    MkChaid chaid
    java.sql.Timestamp arrival_time

    static constraints = {
    }

    static mapping = {
        table 'mst_health_education_mst_view'
        version false
    }
}
