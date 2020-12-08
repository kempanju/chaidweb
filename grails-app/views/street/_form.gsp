

<div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="name.en" default="Name"/> <span class="text-danger">*</span></label>
        <div class="col-lg-5">
            <input type="text" name="name" class="form-control" autocomplete="name" required="required" value="${street?.name}">
        </div>
    </div>


<div class="form-group">
            <label class="control-label col-lg-3">Wilaya</label>

            <div class="col-lg-5">
                <g:select name="district_id" id="district_id" value="${street?.district_id?.id}" onchange="getWards(this)"
                          data-show-subtext="true" data-live-search="true"
                          from="${admin.District.findAllByD_deleted(false)}" optionKey="id" optionValue="name"
                          class="form-control selectpicker" noSelection="['': 'District']"/>

            </div>
        </div>


 <div class="form-group" id="list-ward">

</div>

