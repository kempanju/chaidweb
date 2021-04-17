<fieldset class="content-group">

    <div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="code" default="Code"/> <span class="text-danger">*</span></label>
        <div class="col-lg-5">
            <input type="text" name="code" class="form-control" autocomplete="code" required="required" value="${dictionaryItem?.code}">
        </div>
    </div>
    <div class="form-group">
        <label  class="control-label col-lg-3"><g:message code="name.en" default="Name(English)"/> <span class="text-danger">*</span></label>
        <div class="col-lg-7">
            <input type="text" name="name" class="form-control" autocomplete="name_en" required="required" value="${dictionaryItem?.name}">
        </div>
    </div>

     <div class="form-group">
            <label  class="control-label col-lg-3"><g:message code="name.en" default="Name(Swahili)"/> </label>
            <div class="col-lg-7">
                <input type="text" name="name_en" class="form-control" autocomplete="name_en"  value="${dictionaryItem?.name_en}">
            </div>
        </div>



    <div class="form-group">
        <label class="control-label col-lg-3"><g:message code="dictionary" default="Dictionary"/> <span class="text-danger">*</span></label>

        <div class="col-lg-7">
            <g:select name="dictionary_id" id="dictionary_id" value="${dictionaryItem?.dictionary_id?.id}"
                      from="${admin.Dictionary.findAllByActive(true)}" optionKey="id" optionValue="full_name"
                      class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Dictionary')]"/>

        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-lg-3">Active?</label>

        <div class="col-lg-5">
            <g:checkBox name="active"  value="${dictionaryItem?.active}"/>

        </div>
    </div>
</fieldset>