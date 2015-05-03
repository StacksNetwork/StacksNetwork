<form action="" method="post" id="productform">
    <input type="hidden" name="slider_id" value="{$slider_id}" />
    <input type="hidden" name="make" value="submit" />

    <div class="well form-horizontal">
        <div class="control-group">
            <label for="title" class="control-label">Product Category</label>
            <div class="controls ">
                <select name="category_id" >
                    {foreach from=$categories item=cat}
                    <option value="{$cat.id}" >{$cat.name}</option>
                    {/foreach}
                </select>
                <span class="help-inline">Select category to use products from as slides</span>
            </div>
        </div>

        <button type="submit" class="btn btn-large btn-success" id="submitbutton">Create slides</button>

    </div>
    {securitytoken}
</form>
<script>bindPform()</script>