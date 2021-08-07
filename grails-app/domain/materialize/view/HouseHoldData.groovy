package materialize.view
import admin.District
import admin.Region

class HouseHoldData {
    District district
    Region region
    Integer male_no
    Integer female_no
    Integer totalcount
    static mapping = {
        table 'mst_household_district_mst_view'
        version false
    }
}
