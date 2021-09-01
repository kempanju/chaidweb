package materialize.view

import admin.Region

class RegionReport {
    Integer population
    Region region

    static constraints = {
    }
    static mapping = {
        table 'mst_gathering_region_view'
        version false
    }
}
