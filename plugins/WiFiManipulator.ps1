Clear-Host

$host.UI.RawUI.WindowTitle = "WiFi Manipulator by ContratopDev"


function manipulatemode{ # Manipulate Mode ############################
    $while1 = $true
    while($while1){
        write-host ""
        write-host "Manipulate Mode" -ForegroundColor Cyan
        write-host ""
        write-host "[A] Show All data"
        write-host "[1] - Actual Interface"
        write-host "[2] - Show Profile List"
        write-host "[3] - Show Profile Data"
        write-host "[4] - Delete Profile"
        write-host ""
        write-host "[5] - Import Profile"
        write-host "[6] - WLAN Report (Admin)" -ForegroundColor Magenta
        write-host "[7] - Disconnect Network"
        write-host "[8] - Connect Network"
        write-host ""
        write-host "[D] - Dump mode" -ForegroundColor Yellow
        write-host "[X] - Exit"

        $selection = Read-Host "Select an option"
        if($selection -eq "A"){
            write-host "-----------------------------------------------"
            write-host "Show All data" -ForegroundColor Cyan
            write-host ""
            netsh wlan show all
            write-host ""
            pause

        }
        elseif($selection -eq 1){
            write-host ""
            write-host "Actual Interface" -ForegroundColor Cyan
            write-host ""
            netsh wlan show interfaces
            write-host ""
            pause
        }
        elseif($selection -eq 2){
            write-host ""
            write-host "Show Profile List" -ForegroundColor Cyan
            write-host ""
            netsh wlan show profiles
            write-host ""
            pause
        }
        elseif($selection -eq 3){
            write-host ""
            write-host "Show Profile Data" -ForegroundColor Cyan
            write-host ""
            netsh wlan show profiles
            $searchprofile = Read-Host "Profile Name"
            netsh wlan show profile name=$searchprofile key=clear
            write-host ""
            pause
        }
        elseif($selection -eq 4){
            write-host ""
            write-host "Delete Profile" -ForegroundColor Cyan
            write-host ""
            netsh wlan show profiles
            $searchprofile = Read-Host "Profile Name"
            netsh wlan delete profile name=$searchprofile
            write-host ""
            pause
        }
        elseif($selection -eq 5){
            write-host ""
            write-host "Import Profile" -ForegroundColor Cyan
            write-host ""
            $importprofile = Read-Host "$pwd File Name"
            netsh wlan add profile filename=$importprofile.xml
            write-host "Import Finished"
            write-host ""
            pause
        }
        elseif($selection -eq 6){
            write-host ""
            write-host "WLAN Report (Admin)" -ForegroundColor Cyan
            write-host ""
            netsh wlan show wlanreport
            write-host ""
            pause
        }
        elseif($selection -eq 7){
            write-host ""
            write-host "Disconnect Network" -ForegroundColor Cyan
            write-host ""
            netsh wlan disconnect
            write-host ""
            pause
        }
        elseif($selection -eq 8){
            write-host ""
            write-host "Connect Network" -ForegroundColor Cyan
            write-host ""
            netsh wlan show profiles
            $searchprofile = Read-Host "Profile Name"
            netsh wlan connect name=$searchprofile
            write-host ""
            pause
        }




        elseif($selection -eq "D"){
            $while1 = $false
            dumpmode
        }
        elseif($selection -eq "X"){
            $while1 = $false
            exit
        }
        else{
            write-warning "Invalid Option"
            start-sleep -s 2
        }





    }
}


function dumpmode{ # Dump mode #############################
    $while2 = $true
    while($while2){
        write-host "Dump mode" -ForegroundColor Cyan
        write-host ""
        write-host "[A] - Dump all data"
        write-host "[1] - Dump actual interface"
        write-host "[2] - Dump profile list"
        write-host "[3] - Dump profile data (With Key)" -ForegroundColor Green
        write-host "[33] - Dump Profile data (recurrent)" -ForegroundColor GreenS
        write-host "[4] - Dump profile data & Delete"
        write-host ""
        write-host "[5] - Dump XML (All Profiles)"
        write-host "[6] - Dump WLAN Report (Admin)" -ForegroundColor Magenta
        write-host ""
        write-host "[M] - Manipulate mode" -ForegroundColor Yellow
        write-host "[X] - Exit"

        $selection = Read-Host "Select an option"
        if($selection -eq "A"){
            write-host ""
            write-host "Dump all data" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-AllData.txt"
            netsh wlan show all > "WiFi-AllData.txt"
            write-host "Dump saved in $pwd\WiFi-AllData.txt"
            write-host ""
            pause
        }
        elseif($selection -eq 1){
            write-host ""
            write-host "Dump actual interface" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-ActualInterface.txt"
            netsh wlan show interfaces > "WiFi-ActualInterface.txt"
            write-host "Dump saved in $pwd\WiFi-ActualInterface.txt"
            write-host ""
            pause
        }
        elseif($selection -eq 2){
            write-host ""
            write-host "Dump profile list" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-ProfileList.txt"
            netsh wlan show profiles > "WiFi-ProfileList.txt"
            write-host "Dump saved in $pwd\WiFi-ProfileList.txt"
            write-host ""
            pause
        }
        elseif($selection -eq 3){
            write-host ""
            write-host "Dump profile data (With Key)" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-ProfileData.txt"
            netsh wlan show profiles
            $searchprofile = Read-Host "Profile Name"
            netsh wlan show profile name=$searchprofile key=clear > "WiFi $searchprofile Data.txt"
            write-host "Dump saved in $pwd\WiFi $searchprofile Data.txt"
            write-host ""
            pause
        }
        elseif($selection -eq 33){
            $whilerecurrent = $true
            while($whilerecurrent){
                write-host ""
                write-host "Dump profile data (With Key)" -ForegroundColor Cyan
                write-host ""
                write-host "Dump in $pwd\WiFi-ProfileData.txt"
                netsh wlan show profiles
                $searchprofile = Read-Host "Profile Name (or X to exit)"
                if($searchprofile -eq "x"){
                    $whilerecurrent = $false
                }
                netsh wlan show profile name=$searchprofile key=clear >> "WiFi-ProfileRecurrentData.txt"
                write-host "Dump of $searchprofile finished"
                write-host ""
                pause
            }
        }



        elseif($selection -eq 4){
            write-host ""
            write-host "Dump profile data & Delete" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-ProfileData.txt"
            netsh wlan show profiles
            $searchprofile = Read-Host "Profile Name"
            netsh wlan show profile name=$searchprofile key=clear > "WiFi-ProfileData.txt"
            write-host "Dump saved in $pwd\WiFi-ProfileData.txt"
            write-host ""
            write-host "Delete Profile"
            netsh wlan delete profile name=$searchprofile
            write-host ""
            pause
        }
        elseif($selection -eq 5){
            write-host ""
            write-host "Dump XML (All Profiles)" -ForegroundColor Cyan
            write-host ""
            write-host "Dump all data"
            netsh wlan export profile key=clear
            write-host "Dump completed"
            write-host ""
            pause
        }
        elseif($selection -eq 6){
            write-host ""
            write-host "Dump WLAN Report (Admin)" -ForegroundColor Cyan
            write-host ""
            write-host "Dump in $pwd\WiFi-WLANReport.txt"
            netsh wlan show wlanreport > "WiFi-WLANReport.txt"
            write-host "Dump saved in $pwd\WiFi-WLANReport.txt"
            write-host ""
            pause
        }





        elseif($selection -eq "M"){
            $while2 = $false
            manipulatemode
        }
        elseif($selection -eq "X"){
            $while2 = $false
            exit
        }
        else{
            write-warning "Invalid Option"
            start-sleep -s 2
        }
    }
}




# Mode Init
manipulatemode