package materialize.view

import admin.District


class DistrictReport {
    Integer population
    District district

    static constraints = {
    }
    static mapping = {
        table 'mst_gathering_district_view'
        version false
    }
}
