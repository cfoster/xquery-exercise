# XQuery Exercise and Answers

## XQuery Exercise (**MarkLogic Test**)





### Appendix B

<clip>


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