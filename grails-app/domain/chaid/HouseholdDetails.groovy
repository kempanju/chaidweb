package chaid

import admin.DictionaryItem

class HouseholdDetails {
    int id,version
    Household household
    DictionaryItem detailsType
    Integer member_no=0
    static constraints = {
        member_no nullable:true
    }
}
