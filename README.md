# webconnect
-----

**WebConnectConfiguration**

Use below code on `Appdelegate` in `didFinishLaunchingWithOptions`

```
WebConnectConfiguration()
.baseUrl(baseUrl: "https://reqres.in/api/")
.debug(debug: true)
.timeOut(connectTimeout: 20, readTimeout: 20)
.config()
```

`baseUrl(baseUrl: "https://reqres.in/api/")` - This is required base url for the Api's

`debug(debug: true)` - This is optional method with `true/false`  you can check all the requested logs using this method `debugPrint`

`timeOut(connectTimeout: 20, readTimeout: 20)` - This is optional method using this you can set  connection timeout and read timeout for Api's otherwise bydefauld time out is 60 sec for both timeout.

-----

**HTTP GET**

```
WebConnect.get()
.url(url: "offers")
.header(header: ["Test": "Header"])
.queryParam(queryParam: ["name":"Hello"])
.callback(callback: self)
.tag(tag: 1)
.loader(loader: loaderIndicator)
.connect()
```

`url(url: "offers")` - This is required url for the Api's apart from your baseUrl

`baseUrl(baseUrl: "...")` - Optional if any specific API requires different baseUrl. `By default = that you provided in configuration`

`header(header: ["Test": "Header"])` - Optional  you can pass the `hearder` as `Dictionary` . `By default = nil`

`queryParam(queryParam: ["name":"Hello"])` - Optional method, you can put your `query parameters` as `dictionary`. `By default = nil`

`callback(callback: self)` - Optional, call back method use these two protocol `func onSuccess(response: String, tag: Int)` and `func onError(error: String, tag: Int)` in your viewControllers to get your response. `tag` defines which API response you are getting.
`By default = nil`

`tag(tag: 1)` - Optional, using this you can get this tag value on call back methods , if you are hitting multiple Api's at a same time than you can set tag for each Api's. `By default = 0`

`loader(loader: loaderIndicator)` - Optional, if you want to show loader during hit Api's than you can set your loader.

-----

**HTTP POST**
```
WebConnect.post()
.url(url: "users")
.header(header: ["Test": "Header"])
.bodyParam(bodyParam: ["name":"Amit","job":"manager"])
.tag(tag: 2)
.loader(loader: loaderIndicator)
.callback(callback: self)
.connect()
```
**HTTP PUT**
```
WebConnect.put()
.url(url: "users")
.header(header: ["Test": "Header"])
.bodyParam(bodyParam: ["name":"Amit","job":"manager"])
.tag(tag: 2)
.loader(loader: loaderIndicator)
.callback(callback: self)
.connect()
```
**HTTP DELETE**
```
WebConnect.delete()
.url(url: "users")
.header(header: ["Test": "Header"])
.bodyParam(bodyParam: ["name":"Amit","job":"manager"])
.tag(tag: 2)
.loader(loader: loaderIndicator)
.callback(callback: self)
.connect()
```

`url(url: "offers")` - This is required url for the Api's apart from your baseUrl

`baseUrl(baseUrl: "...")` - Optional if any specific API requires different baseUrl. `By default = that you provided in configuration`

`header(header: ["Test": "Header"])` - Optional  you can pass the `hearder` as `Dictionary` . `By default = nil`

`bodyParam(bodyParam: ["name":"Amit","job":"manager"])` - Optional method, you can put your body parameters as `dictionary` . `By default = nil`

`callback(callback: self)` - Optional, call back method use these two protocol `func onSuccess(response: String, tag: Int)` and `func onError(error: String, tag: Int)` in your viewControllers to get your response. `tag` defines which API response you are getting.
`By default = nil`

`tag(tag: 1)` - Optional, using this you can get this tag value on call back methods , if you are hitting multiple Api's at a same time than you can set tag for each Api's. `By default = 0`

`loader(loader: loaderIndicator)` - Optional, if you want to show loader during hit Api's than you can set your loader.

**Upcoming Features**
1. HTTP PATCH
2. HTTP HEAD
3. Download File
4. Upload Multipart


