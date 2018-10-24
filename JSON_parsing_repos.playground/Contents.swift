
import Foundation

let apiURL: NSURL = NSURL(string: "http://www.omdbapi.com/?apikey=9c2d5c4d&t=Mad+Max+Fury+Road")!

let data = NSData(contentsOf: apiURL as URL)!

let swiftyjson = try JSON(data: data as Data)
//print(swiftyjson)


print("title: ", swiftyjson["Title"])
for (_, rating) in swiftyjson["Ratings"] {
  print(rating["Source"], "gave this movie a", rating["Value"])
}
print("ratings: ", swiftyjson["Ratings"])
print("plot: ", swiftyjson["Plot"])

