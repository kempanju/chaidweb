package admin

class DictionaryItem {

    int version,id
    String name,name_en,code,abbreviation
    Dictionary dictionary_id
    Boolean active=0, displayReport=1
    Integer displayOrder
    static mapping = {
        table name: 'tb_dictionary_item'
        dictionary_id column: 'dictionary_id'


    }
    static constraints = {
        name_en nullable: true
        active nullable:true
        displayOrder nullable:true
        displayReport nullable:true
        abbreviation nullable:true
        code unique:true
    }

    def beforeInsert() {
      // active=1
    }
}
