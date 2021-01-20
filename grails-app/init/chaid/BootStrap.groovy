package chaid

import com.chaid.security.MkpRole
import com.chaid.security.MkpUser
import com.chaid.security.MkpUserMkpRole

class BootStrap {

    def init = { servletContext ->


        TimeZone.setDefault(TimeZone.getTimeZone("Africa/Nairobi"))


        try {
           /* MkpRole.findOrSaveWhere(authority: 'ROLE_DISTRICT')
            MkpRole.findOrSaveWhere(authority: 'ROLE_DATA')
            MkpRole.findOrSaveWhere(authority: 'ROLE_RESPONDENT')

            def adminRole = MkpRole.findOrSaveWhere(authority: 'ROLE_ADM
            def testUser = MkpUser.findOrSaveWhere(username: 'admin', password: '12345', first_name: 'Felix', middle_name: 'M', last_name: 'Joseph', gender: 'Male', phone_number: '255766545878', email: 'felijose82@gmail.com')

            MkpUserMkpRole.create testUser, adminRole

            MkpUserMkpRole.withSession {
                it.flush()
                it.clear()
            }

            assert MkpRole.count() == 1
            assert MkpRole.count() == 1
            assert MkpUserMkpRole.count() == 1*/
           // Facility.executeUpdate("update Facility set deleted=false where deleted=true")

        }catch(Exception e){
            e.printStackTrace()
        }
    }
    def destroy = {
    }
}
