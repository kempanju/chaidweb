package materialize.view
import admin.DictionaryItem
import admin.District
import admin.Region

class ChaidVisitType {
    District district
    Region region
    Integer visitcount
    DictionaryItem visit_type
    static constraints = {
    }
    static mapping = {
        table 'mst_chaid_visit_type_mst_view'
        version false
    }
}
