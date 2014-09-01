xquery version "1.0-ml";

import module namespace search = "http://marklogic.com/appservices/search"
  at "/MarkLogic/appservices/search/search.xqy";

declare namespace ex = "http://marklogician.com/xq-exercise";

declare variable $q as xs:string? := xdmp:get-request-field("q");

if($q) then
(
  search:search(
    $q,
    <options xmlns="http://marklogic.com/appservices/search">
      <additional-query>{cts:collection-query("data")}</additional-query>
      <constraint name="title">
        <word>
          <element name="title"/>
        </word>
      </constraint>
      <constraint name="synopses">
        <element-query ns="" name="synopses"/>
      </constraint>
      <constraint name="type">
        <collection prefix="data-"/>
      </constraint>    
      <return-query>true</return-query>
      <search-option>unfiltered</search-option>
      <transform-results
        apply="raw"
        at="/method-1/clip-transform.xqy"
        ns="http://marklogician.com/xq-exercise/search-transform" />
    </options>
  )
)
else
  fn:error(xs:QName("ex:NO-QUERY-PARAMETER"),
    "Please pass a 'q' parameter to this /search end-point.")