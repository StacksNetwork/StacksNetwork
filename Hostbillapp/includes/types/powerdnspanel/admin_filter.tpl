<tr>
                <td >{$lang.clientlastname}</td>
                <td ><input type="text" value="{$currentfilter.lastname}" size="25" name="filter[lastname]"/></td>

                <td>{$lang.Domain} (zone)</td>
                <td ><input type="text" value="{$currentfilter.domain}" size="25" name="filter[domain]"/></td>

                <td>{$lang.Service}</td>
                <td ><select name="filter[name]">
				<option value=''>{$lang.Any}</option>
				{foreach from=$advanced.products item=o}
                                <option value="{$o.name}" {if $currentfilter.name==$o.name}selected="selected"{/if}>{$o.catname} - {$o.name}</option>
				{/foreach}
				</select></td>
                </tr>
           
