<form action="" method="post" id="singleslide">
    <input type="hidden" name="slider_id" value="{$slider_id}" />
    <input type="hidden" name="id" value="{$id}" />
    <input type="hidden" name="make" value="submit" />

    <div class="well form-horizontal">
        <div class="control-group">
            <label for="title" class="control-label">Slide title</label>
            <div class="controls ">
                <input type="text" name="title" value="{$slide.title}" />
                <span class="help-inline">Enter slide title (used for reference)</span>
            </div>
        </div>
        <div class="control-group">
            <label for="title" class="control-label">Slide type</label>
            <div class="controls ">
                <label class="radio inline">
                    <input type="radio" name="slidertype" value="image" {if $slide.image || !$slide}checked {/if} onclick="$('#textonly').slideUp();$('#image').slideDown();"/>
                    Image + caption text
                </label>
                <label class="radio inline">
                    <input type="radio" name="slidertype" value="text"  {if $slide && !$slide.image}checked{/if} onclick="$('#image').slideUp();$('#textonly').slideDown();" />
                    Text only
                </label>
            </div>
        </div>

        <div id="textonly" {if $slide.image || !$slide}style="display:none"{/if} >
            <div class="control-group">
                <label for="title" class="control-label">Text content</label>
                <div class="controls ">
                    <textarea rows="3" class="span7" name="content">{$slide.content}</textarea>
                </div>
            </div>
        </div>

        <div id="image"  {if $slide && !$slide.image}style="display:none"{/if}>
             <div colspan="2" id="fileupload" data-url="?cmd=hbslider&action=handleupload">
                        <div id="dropzonecontainer">
                        <div id="dropzone"><h2>Drag & drop image here to upload it</h2></div>
                        <div class="fileupload-buttonbar">
                            <div class="span5" style="float:left">
                                <!-- The fileinput-button span is used to style the file input field as button -->
                                <span class="btn fileinput-button">
                                    <i class="icon-plus"></i>
                                    <span>Upload image</span>
                                    <input type="file" name="attachment"   />
                                </span>
                            </div>
                            <!-- The global progress information -->
                            <div class="span5 fileupload-progress fade"  style="float:left">
                                <!-- The global progress bar -->
                                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                    <div class="bar" style="width:0%;"></div>
                                </div>
                                <!-- The extended global progress information -->
                                <div class="progress-extended">&nbsp;</div>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <!-- The table listing the files available for upload/download -->
                        <table role="presentation" class="table table-striped"><tbody class="files">
                                {if $slide.image}
                                <tr class="template-download">
                                    
                                    <td width="100"><img src="../slider/thumbs/{$slide.image}" /></td>
                                    <td class="name" width="40%">{$slide.image} <input type="hidden" name="image" value="{$slide.image}" /></td>
                                    <td class="size"><span></span></td>
                                    <td colspan="2"></td>
                                    <td class="delete" width="90" align="right">
                                        <button class="btn btn-danger btn-mini" data-type="POST" data-url="/?cmd=hbslider&action=handleupload&file={$slide.image}&_method=DELETE">
                                            <i class="icon-trash icon-white"></i>
                                            <span>{$lang.delete}</span>
                                        </button>
                                    </td>
                                </tr>
                                {/if}
                            </tbody></table>
                        <!--EOF: FILEUPLOAD -->
                      

                         </div>
                    </div>

            <div class="control-group">
                <label for="title" class="control-label">Image caption</label>
                <div class="controls ">
                    <textarea rows="3" class="span7" name="caption">{$slide.caption}</textarea>
                </div>
            </div>



        </div>             <button type="submit" class="btn btn-large btn-success" id="submitbutton">Submit slide</button>

    </div>
    {securitytoken}
</form>

<script>bindUploader();</script>