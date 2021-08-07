package materialize.view
import admin.DictionaryItem
import admin.District
import admin.Region
class ChaidMeetingType {
    District district
    Region region
    Integer meetingcount
    DictionaryItem meeting_type
    static constraints = {
    }
    static mapping = {
        table 'mst_chaid_meeting_type_mst_view'
        version false
    }
}
