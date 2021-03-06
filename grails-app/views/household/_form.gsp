<fieldset class="content-group">
 <div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="name.en" default="Name"/> <span class="text-danger">*</span></label>
        <div class="col-lg-7">
            <input type="text" name="name" class="form-control" autocomplete="name" required="required" value="${household?.name}">
        </div>
    </div>


     <div class="form-group">
            <label  class="control-label col-lg-3"><g:message code="name.en" default="Number"/> <span class="text-danger">*</span></label>
            <div class="col-lg-5">
                <input type="text" name="number" class="form-control" autocomplete="number" required="required" value="${household?.number}">
            </div>
        </div>
 <div class="form-group">
            <label class="control-label col-lg-3">Wilaya</label>

            <div class="col-lg-5">
                <g:select name="district_id" id="district_id" value="${household?.district_id?.id}" onchange="getVillages(this)"
                          data-show-subtext="true" data-live-search="true"
                          from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                          class="form-control selectpicker" noSelection="['': 'District']"/>

            </div>
        </div>
        <div class="form-group" id="list-village">


      <label class="control-label col-lg-3">Village</label>
    <div class="col-lg-5">
   <input type="text" name="village_name" placeholder="Village" disabled="disabled" class="form-control"
                          value="${household?.village_id?.name}">
   </div>


</div>




</field>