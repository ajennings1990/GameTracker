# Alamofire Dreamr API Binding

Dreamr bindings for Alamofire for easy-peasy JSON
serialization with endpoints developed at Dreamr.

## Installation

We currently only support CocoaPods.

1. Make sure you have access to the project `pods.dreamr.uk` on gitlab and that you have a 
valid ssh key on your mac. 

2. Add the following files at the top of your `Podfile`.


```ruby
source 'git@gitlab.com:pods.dreamr.uk/podspec.git'
source 'https://github.com/artsy/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'
```

3. Add the dependency:

```ruby
pod 'Alamofire-Dreamr'
```

Note that it depends on `Alamofire` and `SwiftyJSON` so you don't have to add them as well.

## Usage

This extension for `Alamofire` makes it easy to serialize responses from made-by-dreamr API.

### Empty Responses

Use empty responses when you don't care about the response.

```swift

Alamofire
    .request(someURL, .get)
    .responseEmpty { (response: DataResponse<Void>) in 
        // your code
    }
```


### Object Responses

Use object responses when the server returns a single object.
Make sure your custom class/struct implements `Decodable`, then:


```swift

Alamofire
    .request(someURL, .get)
    .responseObject(Something.self) { (response: DataResponse<Something>) in 
        // your code
    }
```


### Array Responses

Use array responses when the server returns an array of objects with or without pagination.
The array has to contain `Decodable`s objects of the same type.

The response is a `PaginatedArray<T>` which is a simple wrapper with the actual data and information
about pagination. 

Information about pagination is defined by `PaginationInfo`.


```swift

Alamofire
    .request(someURL, .get)
    .responseArray(Something.self) { (response: DataResponse<PaginatedArray<Something>>) in 
        // your code
    }

```