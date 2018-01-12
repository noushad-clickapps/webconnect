# webconnect
This is configration for webconnect put this code on `Appdelegate` in `didFinishLaunchingWithOptions method`
```
WebConnectConfiguration()
.baseUrl(baseUrl: "https://reqres.in/api/")
.debug(debug: true)
.timeOut(connectTimeout: 20, readTimeout: 20)
.config()
```

`baseUrl(baseUrl: "https://reqres.in/api/")` - This is required base url for the Api's

`debug(debug: true)` - This is optional method with `debug true/false`  you can check all the requested logs using this method `debugPrint`

`timeOut(connectTimeout: 20, readTimeout: 20)` - This is optional method using this you can set  connection timeout and read timeout for Api's otherwise bydefauld time out is 60 sec for both timeout.

-----


This is get method for webconnect put this code into your controllers where you want to call this method.
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

`url(url: "offers")` - This is required url for the Api's

`header(header: ["Test": "Header"])` - This is optional method , you can pass the `hearder` as string into this method.

`queryParam(queryParam: ["name":"Hello"])` - This is optional method, you can put your query parameters as dictionary into this method.

`callback(callback: self)` - This is optional mehtod for call back method use these two protocol `func onSuccess(response: String, tag: Int)` and `func onError(error: String, tag: Int)` in your viewControllers to get your responds.

`tag(tag: 1)` - This is optional, using this you can get this tag value on call back methods , if you are hitting multiple Api's at a same time than you can set tag for each Api's.

`loader(loader: loaderIndicator)` - This is optional method, if you want to show loader during hit Api's than you can set your loader.

-----

This is post method for webconnect put this code into your controllers where you want to call this method.
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

`url(url: "offers")` - This is required url for the Api's

`header(header: ["Test": "Header"])` - This is optional method , you can pass the `hearder` as string into this method.

`bodyParam(bodyParam: ["name":"Amit","job":"manager"])` - This is optional method, you can put your body parameters as dictionary into this method.

`callback(callback: self)` - This is optional mehtod for call back method use these two protocol `func onSuccess(response: String, tag: Int)` and `func onError(error: String, tag: Int)` in your viewControllers to get your responds.

`tag(tag: 2)` - This is optional, using this you can get this tag value on call back methods , if you are hitting multiple Api's at a same time than you can set tag for each Api's.

`loader(loader: loaderIndicator)` - This is optional method, if you want to show loader during hit Api's than you can set your loader.

```
Note - For these WebConnect.post() , WebConnect.put() ,WebConnect.delete() parameters will be same work.
```
