<div class="form-group">
    <label class="control-label col-lg-4 text-muted"> <g:message code="default.message.username" default="Username"/> </label>

    <div class="col-lg-7">
        <input type="text"
               name="${securityConfig.apf.usernameParameter}"

               class="form-control"
               required="required"
               value="">
    </div>
</div>

<div class="form-group">
    <label class="control-label col-lg-4 text-muted"><g:message code="default.message.password" default="Password"/> </label>

    <div class="col-lg-7">
        <input type="password" name="${securityConfig.apf.passwordParameter}"
               class="form-control" required="required"
               value="">
    </div>
</div>