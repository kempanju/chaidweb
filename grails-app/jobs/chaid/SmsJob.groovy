package chaid

import admin.DictionaryItem
import admin.SystemLogs
import com.chaid.security.MkpUserMkpRole
import grails.util.Environment

class SmsJob {
    ApplicationService applicationService
    static triggers = {
      simple repeatInterval: 10000l // execute job once in 10 seconds
    }

    def execute() {
        // execute job
        def dictionaryItemInstance= DictionaryItem.findByCode("SSMS");

        def logInstanceList= SystemLogs.findAllByLog_typeAndSending_status(dictionaryItemInstance,0,[max:2])
        //println(logInstanceList)
        logInstanceList.each{
            def message=it.message
            def phoneNumber=it.user_id.phone_number
            println(message)
            if (Environment.current == Environment.PRODUCTION) {
                applicationService.sendMessage(phoneNumber, message)
            }
            SystemLogs.executeUpdate("update SystemLogs set sending_status=1 where id=:id",[id:it.id])

        }

    }
}
