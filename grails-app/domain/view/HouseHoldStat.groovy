package view

import admin.District
import admin.Region
import admin.Street
import chaid.Household
import chaid.MkChaid

class HouseHoldStat {
    MkChaid chaid
    Household household
    District district
    Region region
    Street street
    Integer number_of_orders
    static constraints = {
    }

    static mapping = {
        table 'house_hold_stats'
        version false
    }
}
