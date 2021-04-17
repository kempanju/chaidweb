package admin

class SubStreet {
    int id,version
    String name
    District district_id
    Street village_id
    Boolean deleted

    static constraints = {
        deleted nullable: true

        //name (unique:['district_id','village_id'])

    }

    static mapping = {
        table name: 'gen_sub_street'
        district_id column:'district_id'
        village_id column: 'village_id'
    }

    def beforeInsert() {
        deleted=0
    }
}
