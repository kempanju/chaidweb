<fieldset class="content-group">
 <div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="name.en" default="Name"/> <span class="text-danger">*</span></label>
        <div class="col-lg-7">
            <input type="text" name="name" class="form-control" autocomplete="name" required="required" value="${facility?.name}">
        </div>
    </div>


     <div class="form-group">
            <label  class="control-label col-lg-3"><g:message code="name.en" default="Number"/> <span class="text-danger">*</span></label>
            <div class="col-lg-5">
                <input type="text" name="number" class="form-control" autocomplete="number" required="required" value="${facility?.number}">
            </div>
        </div>
            <div class="form-group">
                    <label  class="control-label col-lg-3"><g:message code="name.en" default="Phone Number"/> </label>
                    <div class="col-lg-5">
                        <input type="text" name="mobile_number" class="form-control" autocomplete="mobile_number"  value="${facility?.mobile_number}">
                    </div>
                </div>


    <div class="form-group">
        <label class="control-label col-lg-3"><g:message code="dictionary" default="Facility Type"/> <span class="text-danger">*</span></label>

        <div class="col-lg-7">
            <g:select name="type" id="facilityType" value="${facility?.type?.id}"
                      from="${admin.DictionaryItem.findAllByDictionary_id(admin.Dictionary.findByCode("FAUCYTYPE"))}" optionKey="id" optionValue="name"
                      class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Type')]"/>

        </div>
    </div>

 <div class="form-group">
            <label class="control-label col-lg-3">Wilaya</label>

            <div class="col-lg-5">
                <g:select name="district_id" id="district_id" value="${facility?.district_id?.id}" onchange="getVillages(this)"

                          from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                          class="form-control " noSelection="['': 'District']"/>

            </div>
        </div>
     <div class="form-group" id="list-village">

 <label class="control-label col-lg-3">Village</label>
    <div class="col-lg-5">
   <input type="text" name="village_name" placeholder="Village" disabled="disabled" class="form-control"
                          value="${facility?.village_id?.name}">
   </div>


</div>
</field>

<script>
$( document ).ready(function() {
var district_id='${facility?.district_id?.id}';
 getVillages(district_id);
});
</script>