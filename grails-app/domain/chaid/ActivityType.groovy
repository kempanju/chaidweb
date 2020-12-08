package chaid

import admin.DictionaryItem

class ActivityType {
    int id,version
    Household household
    MkChaid chaid
    DictionaryItem type
    String other_explaination
    static constraints = {
        other_explaination nullable:true
    }
}
