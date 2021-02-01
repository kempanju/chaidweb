package chaid

import com.chaid.security.MkpUser
import grails.converters.JSON
import org.grails.web.json.JSONObject

class TestController {

    def index() { }

    def helloWorld(){
        JSONObject jsonObject=new JSONObject()
        jsonObject.put("message","Hello world!")
        render jsonObject
    }


    def usersList(){
        def userList= MkpUser.findAllByEnabled(true) as JSON
        render userList
    }
}
