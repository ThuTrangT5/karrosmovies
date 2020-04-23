# Karros Movie 
Karros Movie is an application which is implement depend on design 
https://www.figma.com/file/FrVMAtZUuJSLujJZ2uJ4mF/Movie-app?node-id=0%3A1

## There are 2 screens
* Home 
* Detail 


![Home screen](/images/home.png)
![Detail screen](/images/detail.png)

## Requirements:
* Xcode 11+
* iOS 13

## Home screen: there are 5 sections
* Recommendation
* Category
* Popular
* Top rated
* Upcoming


For each section (except Category) data will be **loaded more** when scroll to the end until all data is loaded.


**Pull down** whole Home screen to **reload** all data


**Click** on Movie will go to **Detail screen**

## Detail screen
* Movie name
* Overview description
* Genres
* Write a comment
* Recommendations

There is a **load more** function for Recommendations section (like Home screen) 

**Click** on one Movie of this section will go to another **Detail screen**

## Database: 
https://api.themoviedb.org/3/


## Note: 
I can not find any information about Comments/Casts/Video of a movie so I did not implement them in Detail screen


## Design Pattern:  MVVM

## Libraries: via CocoaPods

* Alamofire 
* SwiftyJSON
* RxSwift
* RxCocoa
* Kingfisher
* MBProgressHUB 

