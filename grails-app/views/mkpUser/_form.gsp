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

                <input type="text" name="middle_name" placeholder="Second Name" class="form-control"
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
                    <label class="control-label col-lg-3">Username </label>

                    <div class="col-lg-5">

                        <input type="text" name="username" placeholder="Username" class="form-control" required="required"
                               value="${mkpUser?.username}">

                    </div>
                </div>

     <div class="form-group">
                <label class="control-label col-lg-3">Phone Number</label>

                <div class="col-lg-5">

                    <input type="text" name="phone_number" placeholder="Phone Number" class="form-control" required="required"
                           value="${mkpUser?.phone_number}">

                </div>
            </div>

         <div class="form-group">
                     <label class="control-label col-lg-3">Region</label>

                     <div class="col-lg-5">
                         <g:select name="region" id="region_id" value="${mkpUser?.region?.id}"
                                   data-show-subtext="true" data-live-search="true"
                                   from="${admin.Region.list()}" optionKey="id" optionValue="name"
                                   class="form-control" noSelection="['': 'Region']"/>

                     </div>
                 </div>

   <div class="form-group">
               <label class="control-label col-lg-3">Wilaya</label>

               <div class="col-lg-5">
                   <g:select name="district_id" id="district_id" value="${mkpUser?.district_id?.id}" onchange="getVillages(this)"

                             from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                             class="form-control " noSelection="['': 'District']"/>

               </div>
           </div>
  

              <div class="form-group" id="list-facility">
                    <label class="control-label col-lg-3"><g:message code="dictionary" default="Facility Name"/> </label>

                    <div class="col-lg-5">
                        <g:select name="facility" id="facility" value="${mkpUser?.facility?.id}"
                                  from="${chaid.Facility.findAllByDistrict_id(mkpUser?.district_id)}" optionKey="id" optionValue="name"
                                  class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Facility')]"/>

                    </div>
                </div>

    




        <div class="form-group" id="list-village">
         <label class="control-label col-lg-3">Village</label>
 <div class="col-lg-5">
<input type="text" name="village_name" placeholder="Village" disabled="disabled" class="form-control"
                       value="${mkpUser?.village_id?.name}">
</div>

   </div>

