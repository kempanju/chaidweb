<fieldset class="content-group">

    <div class="form-group">
        <label  class="control-label col-lg-3">Code <span class="text-danger">*</span></label>
        <div class="col-lg-5">
            <input type="text" name="code" class="form-control" autocomplete="code" required="required" value="${dictionary?.code}">
        </div>
    </div>
    <div class="form-group">
        <label  class="control-label col-lg-3">Name <span class="text-danger">*</span></label>
        <div class="col-lg-7">
            <input type="text" name="name" class="form-control" autocomplete="name" required="required" value="${dictionary?.name}">
        </div>
    </div>

     <div class="form-group">
            <label  class="control-label col-lg-3">Name Sw</label>
            <div class="col-lg-7">
                <input type="text" name="name_en" class="form-control"   value="${dictionary?.name_en}">
            </div>
        </div>

     <div class="form-group">
            <label class="control-label col-lg-3">Active?</label>

            <div class="col-lg-5">
                <g:checkBox name="active"  value="${dictionary?.active}"/>

            </div>
        </div>

         <div class="form-group">
                <label class="control-label col-lg-3">Is Questionnaire?</label>

                <div class="col-lg-5">
                    <g:checkBox name="is_questionnaire"  value="${dictionary?.is_questionnaire}"/>

                </div>
            </div>

</fieldset>