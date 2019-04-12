<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script></script>
 <script>
 $(document).ready(function() {
	    $('#startDate').datepicker({
	        dateFormat: 'dd-mm-yy',
	        onSelect : function(){
	        var weeks = $('#weeks').val();

	        var startDate = $('#startDate').datepicker('getDate');
	        var d = new Date(startDate);
	        
	        var newDate = new Date(d.getFullYear(), d.getMonth(), d.getDate() - weeks * 7);
	        
	        $('#endDate').datepicker('setDate', newDate);
	    }
	});
	$('#endDate').datepicker({dateFormat: 'dd-mm-yy'});
	});
</script>
</head>
<body>
<input name="weeks" id="weeks" type="text" size="20">'Weeks'<br><br>
<input name="startDate" id="startDate" type="text" placeholder="Start Date">
<input name="endDate" id="endDate" type="text" placeholder="End Date">
</body>
</html>