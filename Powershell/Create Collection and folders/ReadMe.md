The script creates 17 folders and 36 collections. 
For more details, see blog post at https://www.systemcenterdudes.com/powershell-script-to-create-collections-with-folder-structure/

The collections will be placed under the right folder based on the purpose of the collection
The collections are set to 7 days refresh period
The overall idea is to keep collections on a per needs basis. 

Full list of folders

![Folderlist](https://github.com/JonathanLefebvreGlobensky/Images/blob/master/Collection%20Folders.jpg)

Full list of collections

All Servers

All Workstations

All Workstations - Admin

MC - CS - Workstation Prod

MC - CS - Workstation Test

MC - CS - Server Prod

MC - CS - Server Test

MC - EP - Workstation Prod

MC - EP - Workstation Test

MC - EP - Server Prod

MC - EP - Server Test

SRV - INV - Physical

SRV - INV - Virtual

SRV - INV - Windows 2008 and 2008 R2

SRV - INV - Windows 2003 and 2003 R2

SRV - INV - Windows 2016

WKS - INV - Windows 7

WKS - INV - Windows 8

WKS - INV - Windows 8.1

WKS - INV - Windows XP

WKS - INV - SCCM Console

WKS - INV - Clients Version | 1710

WKS - INV - Laptops | Dell

WKS - INV - Laptops | Lenovo

WKS - INV - Laptops | HP

WKS - INV - Microsoft Surface 4

WKS - INV - Windows 10

WKS - OSD - Windows 10 - PROD

WKS - OSD - Windows 10 - TEST

WKS - SU - Exclusion

WKS - SU - Pilote

WKS - SU - TEST

WKS - SU - PROD

WKS - SD - Office 365 - PROD

WKS - SD - Office 365 - TEST

Note: The script will show error if the collection already exist, but will continue.

Tip : You can comment out any collections that you don't want using (#) at the begging of the "New/Add-CMCollection" lines in the "Create Collection" Section.

For more details on this script, see the
