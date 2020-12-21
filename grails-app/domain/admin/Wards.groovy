package admin

class Wards {
    int id,version
    String name
    District district_id
    Region region_id
    Boolean ward_visible
    String uniquename
    static constraints = {
        region_id nullable: true
        ward_visible nullable: true
        uniquename nullable:true,unique:true
    }

    static mapping = {
        table name: 'gen_ward'
        region_id column:'region_id'
        district_id column: 'district_id'
       // name (unique: ['region_id','district_id'])
    }

    def beforeInsert() {
        ward_visible=1
    }
}
