#############################################################################
# Author  : Jonathan Lefebvre-Globensky
# Website : www.SystemCenterDudes.com
# Twitter : @jlefebvregloben, @SCDudes
#
# Version : 1.0
# Created : 2020/04/23
# Modified : 
#
# Purpose : This script create collections based on each found Boundary groups in an environment.
# Blog post related : 
# Previous script to create collections with folder structure :https://www.systemcenterdudes.com/powershell-script-create-set-maintenance-collections
# Want more default operationnal collection? See Benoit Lecours powershell script --> https://gallery.technet.microsoft.com/Set-of-Operational-SCCM-19fa8178
#
#############################################################################

#Load Configuration Manager PowerShell Module
Import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')

#Get SiteCode
$SiteCode = Get-PSDrive -PSProvider CMSITE
Set-location $SiteCode":"

#Set the prefix for collections to be created
$CollectionPrefix='BG - '

#Define possible limiting collections
$LimitingCollection = "All Systems"
#$LimitingCollection = "All Workstations"
#$LimitingCollection = "All Workstations - Admin"
#$LimitingCollection = "All Servers"

#Refresh Schedule
$Schedule = New-CMSchedule –RecurInterval Days –RecurCount 1

#Create sub folder for Boundary groups collection
new-item -NAme 'Boundary Groups based collection' -Path $($SiteCode.Name+":\DeviceCollection")
$FolderPath = $SiteCode.name+":\DeviceCollection\Boundary Groups based collection"

#Get the list of all Boundary groups
$BoundaryGroups=Get-CMBoundaryGroup

foreach($BoundaryGroup in $BoundaryGroups)
{
    #Define Collection name
    $CollectionName=$CollectionPrefix+$BoundaryGroup.Name
    #Write-Host $CollectionName
         
    Try
    {
        #Create Collections
        New-CMDeviceCollection -Name $CollectionName -Comment "Collection based on boundary group of the same name" -LimitingCollectionName $LimitingCollection -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
        Write-host *** Collection $CollectionName created ***
    }
    Catch
   {
        Write-host -ForegroundColor Red ("There was an error creating the: " + $CollectionName + " collection. Possible cause is that there's already a collection with that name.")
    }
   #DEfine Collection query
   $CollectionQuery="select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceId in (select resourceid from SMS_CollectionMemberClientBaselineStatus  where  SMS_CollectionMemberClientBaselineStatus.boundarygroups like '%"+$BoundaryGroup.Name+"%') and SMS_R_System.Name not in ('Unknown') and SMS_R_System.Client = '1'"
   # Write-Host $CollectionQuery
   #Add collection query
    Add-CMDeviceCollectionQueryMembershipRule -CollectionName $CollectionName -QueryExpression $CollectionQuery  -RuleName "Boundary Group" |out-null

    # Moving collection to folder
    Try
    {
        Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $CollectionName)
        Write-host *** Collection $CollectionNAme moved to the $folderPath folder ***
    }
    Catch
    {
        Write-host -ForegroundColor Red ("There was an error moving the: " + $CollectionName + " collection.")
    }
}











