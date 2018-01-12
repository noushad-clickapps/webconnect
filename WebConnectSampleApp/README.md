# webconnect
This is configration for webconnect put this code on Appdelegate in didFinishLaunchingWithOptions method
```
WebConnectConfiguration()
    .baseUrl(baseUrl: "https://reqres.in/api/")
    .debug(debug: true)
    .timeOut(connectTimeout: 20, readTimeout: 20)
    .config()
```

`baseUrl(baseUrl: "https://reqres.in/api/")` - this is required base url for the Api's

`debug(debug: true)` - This is optional method with `debug true/false`  you can check all the requested logs using this method `debugPrint`

`timeOut(connectTimeout: 20, readTimeout: 20)` - This is optional method using this you can set  connection timeout and read timeout for Api's otherwise bydefauld time out is 60 sec for both timeout.

-----

