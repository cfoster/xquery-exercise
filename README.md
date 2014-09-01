# XQuery Exercise and Answers

## XQuery Exercise (**MarkLogic Test**)A MarkLogic database contains 100 million documents similar to the sample in appendix A. Each document is in a collection "data" and a collection "data-NAME" where NAME is the type of the document.You are required to write a web service in XQuery for MarkLogic that allows a client to search for documents in the database and return documents similar to Appendix B:1. The search service will have the URL: `/search?q=term`2. The client can search for a word occurring anywhere in the documents.
3. The client should be able to restrict the search to the elements `<title>` and/or `<synopses>`.4. The client should be able to restrict the search to only documents with a specific type.
All search information must be contained in the "q" parameter.Please provide the XQuery code for your search service and any MarkLogic specific configuration settings required to make it work.
### Appendix A
```xml<clip revision="2" pid="p01gd0zf"> <partner><link pid="s0000001"/></partner><ids><id type="pid">p01gd0zf</id></ids><master_brand/><title>Xiaomi: Global plans for Chinese smartphone maker</title><synopses><synopsis length="short">Global plans for Chinese phone maker</synopsis><synopsis length="medium">Xiaomi chief executive, Lei Jun, plans to start selling phones outside China. </synopsis><synopsis length="long">The chief executive of Xiaomi, Lei Jun, tells the BBC that he plans to sell his company's smartphones outside China.</synopsis></synopses><genres/><formats/><media_type value="audio_video"/><shoot_date/></clip>
```

### Appendix B
```xml
<clip><pid>p01gd0zf</pid><partner>s0000001</partner><updated_time>2013-09-10T01:44:43Z</updated_time><title>Xiaomi: Global plans for Chinese smartphone maker</title><synopses><short>Global plans for Chinese phone maker</short><medium>Xiaomi chief executive, Lei Jun, plans to start selling phones outside China. </medium><long>The chief executive of Xiaomi, Lei Jun, tells the BBC that he plans to sell his company's smartphones outside China.</long></synopses><media_type>Video</media_type></clip>
```


## **Answers** (2 Methods)

I created two XQuery search apps to demonstrate how to solve the problem, "Method 1" and "Method 2".

## Method 1 (Simple)

### How it works

The first approach is quite basic and simple.

* Basic URL rewriter
* Uses the Search API to search and parse the users query
* Transforms results using just XQuery

### Files used in Method 1

```
/method-1/search.xqy
/method-1/rewriter.xqy
/method-1/clip-transform.xqy
```

### Specific Setup/Config
* port: 8080
* rewrite handler: /method-1/rewriter.xqy
* default user: admin
* authentication: application-level
* Modules: Modules (Load Modules into the Modules database)
* Collection lexicon **is required** for this `search:search` example


## Method 2 (More advanced)

### How it works and why

The second approach is perhaps more flexible for a larger solution.

* Uses Jim Fuller's RXQ [2] (RESTXQ implementation) as a URL Rewriter.
  * RESTXQ is like JAX-RS, but for XQuery, introduced at XML Prague 2012 [1].
* Uses Michael Blakeley's XQYSP [3] library instead of MarkLogic's Search API.
  * If a user has exact requirements, you can always create your own search grammer and use the REx Parser Generator [4].
* Result items are transformed by XSLT instead of XQuery.
* Added in a little pagination which also stops millions of results potentially coming through (if there were millions).
  
### Files used in Method 2

```
/method-2/search-entry-point.xqy
/method-2/xsl/clip-transform.xsl

And module library files taken from XQYSP and RXQ:

/lib/query-eval.xqy
/lib/rxq-rewriter.xqy
/lib/rxq.xqy
/lib/xqysp.xqy
```

### Specific Setup/Config

* port: 80
* error handler: /lib/rxq-rewriter.xqy?mode=error
* rewrite handler: /lib/rxq-rewriter.xqy?mode=rewrite
* default user: admin
* authentication: application-level
* Modules: Modules (Load Modules into the Modules database)


[1]: http://archive.xmlprague.cz/2012/sessions.html#RESTful-XQuery---Standardised-XQuery-3.0-Annotations-for-REST
[2]: https://github.com/xquery/rxq
[3]: https://github.com/mblakele/xqysp
[4]: http://www.bottlecaps.de/rex/