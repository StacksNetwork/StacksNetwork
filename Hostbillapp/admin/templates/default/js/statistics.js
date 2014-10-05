
function showDatepick(e){
	if($(e).hasClass('activated')){
		$('#pickspan').hide();
		$(e).removeClass('activated').addClass('menul').prevAll('.menuitm').show();
	}else{
		$('#pickspan').show();
		$(e).addClass('activated').removeClass('menul').prevAll('.menuitm').hide();
	}
		return false;
}

function submitdate(act){
		var date = $('#daterange').val();
		var month = $('#daterangem').val()
		if(month){
			month = (parseInt(month)+1).toString();
			if(month.length==1)
				month = '0'+month;
			month = month+'&range=month'
		}else month = '';
		
		if(date)
			window.location = '?cmd=stats&action='+act+'&from='+date+month;
		return false;
}