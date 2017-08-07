<!-- saved from url=(0014)about:internet -->
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script src="AC_OETags.js" language="javascript"></script>
<style>
body { margin: 0px; overflow:hidden }
</style>
<script language="JavaScript" type="text/javascript">
<!--
// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 9;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 28;
// -----------------------------------------------------------------------------
var currURL='';
var isChangingURL=false;
var inCriticalSection=false;
function loadContent(url){
	inCriticalSection=true;
	parent.content.location.href=url;
	currURL=url;
	isChangingURL=(currURL != parent.content.location.href);
	inCriticalSection=false;
}
function loadParentContent(url){
	parent.location.href = url;
}
function loadContentNewWindow(url){
	var lcnw=parent.window.open(url,'','height=600,width=700,scrollbars=yes,resizable=yes,toolbar=yes,menubar=no,location=no,directories=no');
}
function pollForUrlChange(){
	if (!inCriticalSection) {
		if (isChangingURL) {
			if (currURL == parent.content.location.href) isChangingURL = false;
		}
		else if (currURL.length>0 && parent.content.location.href != currURL) {
			currURL=parent.content.location.href;
			var swf=(navigator.appName.indexOf('Microsoft')!=-1 ? window['gedcom'] : document['gedcom']);
			if (swf && swf.browserUrlChange) swf.browserUrlChange(currURL);
		}
	}	
}
function init(){
	setInterval('pollForUrlChange()', 50);
}
window.onload=init;
// -->
</script>
</head>

<body scroll="no">
<script language="JavaScript" type="text/javascript">
<!--
// Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
var hasProductInstall = DetectFlashVer(6, 0, 65);

// Version check based upon the values defined in globals
var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);

if ( hasProductInstall && !hasRequestedVersion ) {
	// MMdoctitle is the stored document.title value used by the installation process to close the window that started the process
	// This is necessary in order to close browser windows that are still utilizing the older version of the player after installation has completed
	// DO NOT MODIFY THE FOLLOWING FOUR LINES
	// Location visited after installation is complete if installation is required
	var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
	var MMredirectURL = window.location;
    document.title = document.title.slice(0, 47) + " - Flash Player Installation";
    var MMdoctitle = document.title;

	AC_FL_RunContent(
		"src", "playerProductInstall",
		"FlashVars", "MMredirectURL="+MMredirectURL+'&MMplayerType='+MMPlayerType+'&MMdoctitle='+MMdoctitle+"",
		"width", "100%",
		"height", "100%",
		"align", "middle",
		"id", "gedcom",
		"quality", "high",
		"bgcolor", "#90b0ff",
		"name", "gedcom",
		"allowScriptAccess","sameDomain",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
} else if (hasRequestedVersion) {
	// if we've detected an acceptable version
	// embed the Flash Content SWF when all tests are passed
	AC_FL_RunContent(
			"src", "gedcom.41",
			"flashVars", "gedcomId=<?php echo urlencode(@$_REQUEST['gedcomId']); ?>",
			"width", "100%",
			"height", "100%",
			"align", "middle",
			"id", "gedcom",
			"quality", "high",
			"bgcolor", "#90b0ff",
			"name", "gedcom",
			"allowScriptAccess","sameDomain",
			"type", "application/x-shockwave-flash",
			"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
  } else {  // flash is too old or we can't detect the plugin
    var alternateContent = 'Alternate HTML content should be placed here. '
  	+ 'This content requires the Adobe Flash Player. '
   	+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
    document.write(alternateContent);  // insert non-flash content
  }
// -->
</script>
<noscript>
  	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="gedcom" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="gedcom.41.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#90b0ff" />
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="flashVars" value="gedcomId=<?php echo urlencode(@$_REQUEST['gedcomId']); ?>"/>
			<embed src="gedcom.41.swf" quality="high" bgcolor="#90b0ff"
				flashVars="gedcomId=<?php echo urlencode(@$_REQUEST['gedcomId']); ?>"
				width="100%" height="100%" name="gedcom" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</noscript>
</body>
</html>
