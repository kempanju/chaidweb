package admin

class Dictionary {
    int version,id
    String name,name_en,code,full_name
    Boolean active,is_questionnaire
    static mapping = {
        table name: 'tb_dictionary'
    }
    static constraints = {
        name_en nullable: true
        is_questionnaire nullable:true
        active nullable:true
        code unique:true
        full_name formula: "CONCAT(code,' - ',name)"
    }
    def beforeInsert() {
        active=1
    }
}
