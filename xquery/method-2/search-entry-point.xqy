xquery version "1.0-ml";

module namespace ex = "http://marklogician.com/xq-exercise";

import module namespace rxq = "http://exquery.org/ns/restxq"
  at "/lib/rxq.xqy";
import module namespace qe = "com.blakeley.xqysp.query-eval"
  at "/lib/query-eval.xqy";

declare variable $MAX-RESULTS-PER-PAGE := 5;

declare
  %rxq:GET
  %rxq:path('/search')
  %rxq:produces('text/xml')
function ex:search()
{
  let $q as xs:string? := map:get(rxq:raw-params(), "q")

  return if($q) then
  (
    (: ---- a little pagination + stopping huge results sets ---- :)
    let $from as xs:integer :=
      from((map:get(rxq:raw-params(), "from"), 1)[1] cast as xs:integer)
    let $to as xs:integer :=
      to($from, (map:get(rxq:raw-params(), "length"), $MAX-RESULTS-PER-PAGE)[1]
                  cast as xs:integer)
    (: ---------------------------------------------------------- :)

    let $query as cts:query := qe:parse($q)
    return
    <result>
    {
      fn:map( (: now changed to "fn:for-each" in W3 XQuery 3.0 Recommendation :)
        xdmp:xslt-invoke("/method-2/xsl/clip-transform.xsl", ?, (),
        <options xmlns="xdmp:eval">
          <isolation>same-statement</isolation> 
        </options>),
        cts:search(fn:collection("data"), $query, "unfiltered")[$from to $to]
      ),

      comment { "cts:query used: " || $query },
      comment { "from result: " || $from },
      comment { "to result: " || $to },
      comment { "elapsed time: " || xdmp:elapsed-time() }

    }
    </result>
  )
  else
    fn:error(xs:QName("ex:NO-QUERY-PARAMETER"),
             "Please pass a 'q' parameter to this /search end-point.")
};

declare %private function from($from as xs:integer) {
  if($from le 0) then 1 else $from
};

declare %private function to($from as xs:integer, $length as xs:integer) {
  $from + fn:min((fn:abs($length), $MAX-RESULTS-PER-PAGE)) - 1
};