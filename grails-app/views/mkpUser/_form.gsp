<div class="form-group">
            <label class="control-label col-lg-3">First Name</label>

            <div class="col-lg-5">

                <input type="text" name="first_name" placeholder="First Name" class="form-control" required="required"
                       value="${mkpUser?.first_name}">

            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-lg-3">Middle Name</label>

            <div class="col-lg-5">

                <input type="text" name="middle_name" placeholder="Second Name" class="form-control" required="required"
                       value="${mkpUser?.middle_name}">

            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-lg-3">Last Name</label>

            <div class="col-lg-5">

                <input type="text" name="last_name" placeholder="Last Name" class="form-control" required="required"
                       value="${mkpUser?.last_name}">

            </div>
        </div>

         <div class="form-group">
                    <label class="control-label col-lg-3">Email </label>

                    <div class="col-lg-5">

                        <input type="text" name="email_address" placeholder="Email" class="form-control" required="required"
                               value="${mkpUser?.email}">

                    </div>
                </div>

     <div class="form-group">
                <label class="control-label col-lg-3">Phone Number</label>

                <div class="col-lg-5">

                    <input type="text" name="phone_number" placeholder="Phone Number" class="form-control" required="required"
                           value="${mkpUser?.phone_number}">

                </div>
            </div>

            <g:if test="${params.id}">

              <div class="form-group">
                    <label class="control-label col-lg-3"><g:message code="dictionary" default="Facility Name"/> <span class="text-danger">*</span></label>

                    <div class="col-lg-5">
                        <g:select name="facility" id="facility" value="${mkpUser?.id}"
                                  from="${chaid.Facility.findAllByDistrict_id(mkpUser?.district_id)}" optionKey="id" optionValue="name"
                                  class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Facility')]"/>

                    </div>
                </div>

            </g:if>



   <div class="form-group">
               <label class="control-label col-lg-3">Wilaya</label>

               <div class="col-lg-5">
                   <g:select name="district_id" id="district_id" value="${mkpUser?.district_id?.id}" onchange="getVillages(this)"
                             data-show-subtext="true" data-live-search="true"
                             from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                             class="form-control selectpicker" noSelection="['': 'District']"/>

               </div>
           </div>
        <div class="form-group" id="list-village">
         <label class="control-label col-lg-3">Village</label>
 <div class="col-lg-5">
<input type="text" name="village_name" placeholder="Village" disabled="disabled" class="form-control"
                       value="${mkpUser?.village_id?.name}">
</div>
   </div>

