xquery version "1.0-ml";

module namespace st = "http://marklogician.com/xq-exercise/search-transform";

declare namespace search = "http://marklogic.com/appservices/search";

declare function st:raw(
   $result as node(),
   $ctsquery as schema-element(cts:query),
   $options as element(search:transform-results)?) {
  <clip>
    <pid>
      {$result/clip/@pid/fn:string()}
    </pid>
    <partner>
      {$result/clip/partner/link/@pid/fn:string()}
    </partner>
    <updated_time>
      {
        fn:current-dateTime(),
        comment { 
          "No updated time in Appendix A, so using" ||
          "fn:current-dateTime() for completeness" }
      }
    </updated_time>

    {$result/clip/title}

    <synopses> {
      st:synopsis(
        $result/clip/synopses/synopsis
      )
    }</synopses>

    <media_type>
    {
      switch ($result/clip/media_type/@value/fn:string())
        case "audio_video" return "Video"
        default return "None-Video --- I guess. (Just 1 example in Appendix A)"
    }
    </media_type>
  </clip>
};

declare function st:synopsis($synopsis as element(synopsis)) as element() {
  element { fn:QName("", $synopsis/@length) } {
    $synopsis/node()
  }
};


