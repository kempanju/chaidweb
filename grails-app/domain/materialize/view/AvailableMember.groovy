package materialize.view
import admin.District
import admin.Region
import admin.DictionaryItem

class AvailableMember {
    District district
    Region region
    Integer meetingcount
    DictionaryItem type_id

    static constraints = {
    }
    static mapping = {
        table 'mst_available_member_house_mst_view'
        version false
    }
}
