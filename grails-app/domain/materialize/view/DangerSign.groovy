package materialize.view

import admin.DictionaryItem
import chaid.MkChaid

class DangerSign {
    MkChaid chaid
    DictionaryItem signType
    static constraints = {
    }
    static mapping = {
        table 'mst_danger_signs_view'
        version false
    }
}
