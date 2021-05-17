                    <label class="control-label col-lg-3"><g:message code="dictionary" default="Facility Name"/> <span class="text-danger">*</span></label>

                    <div class="col-lg-5">
                        <g:select name="facility" id="facility"
                                  from="${facilityListInstance}" optionKey="id" optionValue="name"
                                  class="form-control select-search " noSelection="['': message(code:'select.dictionary', default:'Select Facility')]"/>

                    </div>
