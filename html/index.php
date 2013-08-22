<html>
<head>
<title>Review GEDCOM</title>
<script type="text/javascript">
if (top.location != self.location) top.location = self.location;
</script>
</head>
<frameset rows="40%,60%">
<frame src="review.php?gedcomId=<?php echo urlencode(@$_REQUEST['gedcomId']); ?>" name="review" id="review"/>
<frame src="/wiki/Help:Review_GEDCOM" name="content" id="content"/>
<noframes>
<body>Your browser must support frames in order to review your GEDCOM</body>
</noframes>
</frameset>
</html>
