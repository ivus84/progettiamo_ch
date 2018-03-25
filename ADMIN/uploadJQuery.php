<?php
ini_set("memory_limit","99M");
ini_set("max_execution_time","1200");
ini_set("max_input_time","1200");
ini_set("upload_max_filesize","12M");
ini_set("post_max_size","14M");

$checkrefer = $_SERVER['HTTP_REFERER'];

$pos = strrpos($checkrefer, "/admin");

if ($pos > 0 ) {

$tabdest = $_POST ['tabdest'];

$fileprefix = $_SERVER['HTTP_HOST'];
$fileprefix = str_replace("www","",$fileprefix);
$fileprefix = str_replace("preview","",$fileprefix);
$fileprefix = str_replace(":","",$fileprefix);
$fileprefix = str_replace("localhost","progettiamo.ch",$fileprefix);
$fileprefix = str_replace("lavb.ch","progettiamo.ch",$fileprefix);
$fileprefix = str_replace("test.","",$fileprefix);
$fileprefix  .= date("mdYHis");

$percorso = "../../database/images/";

if ($tabdest == "fails" || $tabdest == "products" || $tabdest == "fieldF") { 
$percorso = "../../database/files/";
} 

if ($tabdest == "registeredusers" || $tabdest == "p_projects" || $tabdest == "p_pictures" || $tabdest == "p_description") { 
$percorso = "../../database/projects/";
} 


$totfiless="";
$totsizess="";
$totfile=0;
$x=0;

while(list($key,$value) = each($_FILES["files"]["name"]))
{
if(!empty($value)){
$filename = $value;
$origExt = substr($filename, strrpos($filename,"."));
$safe_filename=$fileprefix ."_".$x.$origExt;

$gSize=$_FILES["files"]["size"][$key];

copy($_FILES["files"]["tmp_name"][$key], $percorso . $safe_filename);    

$totfile++;
$x++;

$totfiless .= "," . $safe_filename."#".$gSize."#".$filename ;

$totsizess .= "," . $gSize;

}

}


$totfiless = substr($totfiless, 1);
$totsizess = substr($totsizess, 1);

$totfiles = explode(",",$totfiless);
$totsizes = explode(",",$totsizes);
$filesrefs="";

if (strlen($totfiless)>0) {

$getResults="";

for ($x=0; $x<count($totfiles); $x++)
	{

	$getFile=explode('#',$totfiles[$x]);
	$getResults.=',{"name":"'.$getFile[2].'","size":"'.$getFile[1].'","url":"'.$getFile[0].'","thumbnail_url":"","delete_url":"","delete_type":"DELETE"}';

}

$getResults = '['.substr($getResults, 1).']';
header("Content-Type: text/plain");
echo $getResults;
}	
}

?>