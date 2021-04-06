#############################################################################
# Author  : Jonathan Lefebvre-Globensky
# Website : www.SystemCenterDudes.com
# Twitter : @jlefebvregloben, @SCDudes
#
# Version : 1.0
# Created : 2020/01/27
# Modified : 
#
# Purpose : This script is made to determine the Office architecture(bitness) no matter of the version(XP or higher) installed. 
#           It looks at the bitness of Outlook. To be used in SCCM/MEMCM Global Condition.
#           Script return x64, x86 or nothing.
# Blog post related :
# 
#
#############################################################################
#Set Office version counter
$OfficeVersion=10
DO
{
   # Write-host "check for Office version "$OfficeVersion
    $Path ="HKLM:\SOFTWARE\Microsoft\Office\"+$OfficeVersion+".0\Outlook"
   #Test if path exist
    If ((Test-Path $Path))
    {
        # Write-host $Path
        # set $Outlook to the bitness found
        $Outlook =get-itemproperty -path $Path -name "Bitness"

        
    }

    #Increment Office version counter
    $OfficeVersion++
}Until ($OfficeVersion-eq 17) #Loop until version 16 is done


#Validate if $outlook is already found under x86 registry
If(!($Outlook))

{
    #Reset OfficeVersion counter
    $OfficeVersion=10
    DO
    {
        # Write-host "check for Office version "$OfficeVersion
        $Path ="HKLM:\Software\WOW6432Node\Microsoft\Office\"+$OfficeVersion+".0\Outlook"
   
        If ((Test-Path $Path))
        {
            # Write-host $Path
            $Outlook =get-itemproperty -path $Path -name "Bitness"

        
        }

         #Increment Office version counter
        $OfficeVersion++
    }Until ($OfficeVersion-eq 17)

}

#Return valu of Outlook bitness
return $outlook.Bitness
