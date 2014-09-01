xquery version "1.0-ml";

declare variable $url := xdmp:get-request-url();

if(fn:starts-with($url,"/search")) then
  "/method-1/search.xqy?q=" || xdmp:get-request-field("q")
else
  "unknown.html"
