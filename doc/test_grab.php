<?php

function getElementsByClassName(DOMDocument $DOMDocument, $ClassName)
{
    $Elements = $DOMDocument->getElementsByTagName("*");
    $Matched = array();
 
    foreach($Elements as $node)
    {
        if(!$node->hasAttributes())
            continue;
 
        $classAttribute = $node->attributes->getNamedItem('class');
 
        if(!$classAttribute)
            continue;
 
        $classes = explode(' ', $classAttribute->nodeValue);
 
        if(in_array($ClassName, $classes))
            $Matched[] = $node;
    }
 
    return $Matched;
}
$base = "http://tsp.tku.edu.tw/";
$content1 = file_get_contents($base);
$content1 = preg_replace("/big5|Big5/", "utf-8", $content1);
$content1 = iconv(mb_detect_encoding($content1, mb_detect_order(), true), "UTF-8", $content1);
$content1 = preg_replace("/&nbsp;/", "", $content1);
$dom1 = new DOMDocument;
@$dom1->loadHTML($content1);
$a = $dom1->getElementsByTagName("a");
$department = array();
foreach ($a as $value) {
	$v = trim($value->nodeValue);
	if (preg_match("/faculty/", $value->getAttribute("href")) && !empty($v)) {
		$href = $value->getAttribute("href");
		$content2 = file_get_contents($base . $href);
		$content2 = preg_replace("/big5|Big5/", "utf-8", $content2);
		$content2 = iconv(mb_detect_encoding($content2, mb_detect_order(), true), "UTF-8", $content2);
		$content2 = preg_replace("/&nbsp;/", "", $content2);
		$dom2 = new DOMDocument;
		@$dom2->loadHTML($content2);
		$msonormal = getElementsByClassName($dom2, "MsoNormal");
		$sub_name = null;
		$department_name = null;
		foreach ($msonormal as $value1) {
			$vv = trim($value1->nodeValue);
			if (empty($vv)) {
				continue;
			}
			if (preg_match("/院|軍 訓 室|體 育 事 務 處/", $vv)) {
				$department_name = trim($value1->nodeValue);
				$department[$department_name] = array();
				continue;
			}
			if (preg_match("/系|中心|所|軍訓室|事務處/", $vv)) {
				$sub_name = trim($value1->nodeValue);
				$department[$department_name][$sub_name] = array();
				continue;
			}
			if (preg_match("/回首頁/", $vv)) {
				continue;
			}
			if (isset($department_name) && isset($sub_name)) {
				$department[$department_name][$sub_name][] = trim($vv);
			}
		}
	}
}
echo json_encode($department);
?>