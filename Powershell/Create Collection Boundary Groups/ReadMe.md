
This PowerShell script automatically create collections based on all the available boundary groups.
![CollectionExample](https://github.com/JonathanLefebvreGlobensky/Images/blob/master/154930(3).jpg)




$CollectionPrefix let you decide what, if any, characters should be at the beginning of the colllection
by default it is set to BG - 

$LimitingColelction
There is some default limiting collection options that are available, based on my previous script to create Master Collections
Simply uncomment the desired limiting collection

$Schedule
Refresh of the collection is set to once a day by default
A new folder is created at the root of all device collections, called Boundary Groups based collection
All new collections are moved there by default.
