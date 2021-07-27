package admin



class Region {

    int id,version
    String code,name
   // Country country_id
    java.sql.Timestamp created_at
    def user
    def springSecurityService


    static mapping = {
        table name: 'gen_region'
        //country_id column:'country_id'
        created_by column: 'created_by'
    }

    static constraints = {
        code nullable: true, unique: true
        created_at nullable: true
    }

    def beforeUpdate = {
        def current_time = Calendar.instance
        created_at = new java.sql.Timestamp(current_time.time.time)

    }
}
