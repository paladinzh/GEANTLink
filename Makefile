#
#    Copyright 1991-2016 Amebis
#    Copyright 2016 GÉANT
#
#    This file is part of GÉANTLink.
#
#    GÉANTLink is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    GÉANTLink is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
#

PRODUCT_NAME=GEANTLink
OUTPUT_DIR=output

!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
PLAT=x64
REG_FLAGS=/f /reg:64
REG_FLAGS32=/f /reg:32
!ELSE
PLAT=Win32
REG_FLAGS=/f
!ENDIF


All ::

Clean ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean
	cd "$(MAKEDIR)"
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=En PLAT=Win32 CFG=Release
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=En PLAT=Win32 CFG=Debug
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=En PLAT=x64   CFG=Release
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean LANG=En PLAT=x64   CFG=Debug
	cd "$(MAKEDIR)"
	devenv.com "VS10Solution.sln" /clean "Release|Win32"
	devenv.com "VS10Solution.sln" /clean "Debug|Win32"
	devenv.com "VS10Solution.sln" /clean "Release|x64"
	devenv.com "VS10Solution.sln" /clean "Debug|x64"
	-if exist "$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\de_DE\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\de_DE\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\el_GR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\el_GR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\es_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\es_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\it_IT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\it_IT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.3.msi"      del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.3.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.3.msi"     del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.3.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.3.msi"      del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.3.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.3.msi"     del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.3.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"  del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"  del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi" del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi"
	-if exist "$(OUTPUT_DIR)\Setup\CredWrite.exe"          del /f /q "$(OUTPUT_DIR)\Setup\CredWrite.exe"
	-if exist "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"      del /f /q "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"
	-if exist "$(OUTPUT_DIR)\Setup\WLANManager.exe"        del /f /q "$(OUTPUT_DIR)\Setup\WLANManager.exe"

!IFNDEF HAS_VERSION

######################################################################
# 1st Phase
# - Version info parsing
######################################################################

All \
Setup \
SetupDebug \
Register \
Unregister \
StopServices \
StartServices \
Localization \
Publish :: "MSI\MSIBuild\Version\Version.mak"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) HAS_VERSION=1 $@

"MSI\MSIBuild\Version\Version.mak" ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Version
	cd "$(MAKEDIR)"

GenRSAKeypair :: \
	"include\KeyPrivate.bin" \
	"include\KeyPublic.bin"

"include\KeyPrivate.bin" :
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe genrsa 2048 | openssl.exe rsa -inform PEM -outform DER -out "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"include\KeyPublic.bin" : "include\KeyPrivate.bin"
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe rsa -in $** -inform DER -outform DER -out "$(@:"=).tmp" -pubout
	move /y "$(@:"=).tmp" $@ > NUL

!ELSE

######################################################################
# 2nd Phase
# - The version is known, do the rest.
######################################################################

!INCLUDE "MSI\MSIBuild\Version\Version.mak"
!INCLUDE "include\MSIBuildCfg.mak"

PUBLISH_PACKAGE_DIR=..\$(PRODUCT_NAME)-dist
#PUBLISH_PACKAGE_DIR=..\$(PRODUCT_NAME)-dist\$(MSIBUILD_VERSION_STR)


######################################################################
# Main targets
######################################################################

All :: \
	Setup

Setup :: \
	"$(OUTPUT_DIR)\Setup" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi" \
	"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
	"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" \
	"$(OUTPUT_DIR)\Setup\WLANManager.exe"

SetupDebug :: \
	"$(OUTPUT_DIR)\Setup" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi"

Register :: \
	StopServices \
	Localization \
	RegisterSettings \
	RegisterDLLs \
	StartServices \
	RegisterShortcuts

Unregister :: \
	UnregisterShortcuts \
	StopServices \
	UnregisterDLLs \
	UnregisterSettings \
	StartServices

StartServices ::
	cmd.exe /c <<"$(TEMP)\start_EapHost.bat"
@echo off
net.exe start EapHost
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable dot3svc service (Wired AutoConfig) and start it
	sc.exe config dot3svc start= auto
	cmd.exe /c <<"$(TEMP)\start_dot3svc.bat"
@echo off
net.exe start dot3svc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable Wlansvc service (WLAN AutoConfig) and start it
	sc.exe config Wlansvc start= auto
	cmd.exe /c <<"$(TEMP)\start_Wlansvc.bat"
@echo off
net.exe start Wlansvc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP

StopServices ::
	-net.exe stop Wlansvc
	-net.exe stop dot3svc
	-net.exe stop EapHost

RegisterSettings ::
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS32) > NUL
!ENDIF

UnregisterSettings ::
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS32) > NUL
!ENDIF

RegisterDLLs :: \
	"$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}" /ve                           /t REG_SZ    /d "$(MSIBUILD_PRODUCT_NAME)-Events"                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}" /v "MessageFileName"          /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}" /v "ResourceFileName"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"      /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532"                                            /ve                           /t REG_SZ    /d "$(MSIBUILD_PRODUCT_NAME)"                               /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerDllPath"              /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll"     /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerConfigUIPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerIdentityPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerInteractiveUIPath"    /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerFriendlyName"         /t REG_SZ    /d "@$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll,-1" /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerInvokePasswordDialog" /t REG_DWORD /d 0                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "PeerInvokeUsernameDialog" /t REG_DWORD /d 0                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                         /v "Properties"               /t REG_DWORD /d 389871807                                                /f > NUL

UnregisterDLLs ::
	-reg.exe delete "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532" /f > NUL

RegisterShortcuts :: \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk"

UnregisterShortcuts ::
	-if exist "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" rd /s /q "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)"

Publish :: \
	"$(PUBLISH_PACKAGE_DIR)" \
	"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)32.msi" \
	"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)64.msi" \
	"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" \
	"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe" \
	"$(PUBLISH_PACKAGE_DIR)\WLANManager.exe"

Localization :: \
	"$(OUTPUT_DIR)\locale\bg_BG" \
	"$(OUTPUT_DIR)\locale\ca_ES" \
	"$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\cs_CZ" \
	"$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\cy_UK" \
	"$(OUTPUT_DIR)\locale\de_DE" \
	"$(OUTPUT_DIR)\locale\de_DE\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\el_GR" \
	"$(OUTPUT_DIR)\locale\el_GR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\es_ES" \
	"$(OUTPUT_DIR)\locale\es_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\eu_ES" \
	"$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fi_FI" \
	"$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fr_CA" \
	"$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fr_FR" \
	"$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\gl_ES" \
	"$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\hr_HR" \
	"$(OUTPUT_DIR)\locale\hu_HU" \
	"$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\is_IS" \
	"$(OUTPUT_DIR)\locale\it_IT" \
	"$(OUTPUT_DIR)\locale\it_IT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\lt_LT" \
	"$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\nb_NO" \
	"$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\nl_NL" \
	"$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\pl_PL" \
	"$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\pt_PT" \
	"$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\ru_RU" \
	"$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sk_SK" \
	"$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sl_SI" \
	"$(OUTPUT_DIR)\locale\sr_RS" \
	"$(OUTPUT_DIR)\locale\sv_SE" \
	"$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\tr_TR" \
	"$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\vi_VN" \
	"$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"


######################################################################
# Folder creation
######################################################################

"$(OUTPUT_DIR)" \
"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\locale\bg_BG" \
"$(OUTPUT_DIR)\locale\ca_ES" \
"$(OUTPUT_DIR)\locale\cs_CZ" \
"$(OUTPUT_DIR)\locale\cy_UK" \
"$(OUTPUT_DIR)\locale\de_DE" \
"$(OUTPUT_DIR)\locale\el_GR" \
"$(OUTPUT_DIR)\locale\es_ES" \
"$(OUTPUT_DIR)\locale\eu_ES" \
"$(OUTPUT_DIR)\locale\fi_FI" \
"$(OUTPUT_DIR)\locale\fr_CA" \
"$(OUTPUT_DIR)\locale\fr_FR" \
"$(OUTPUT_DIR)\locale\gl_ES" \
"$(OUTPUT_DIR)\locale\hr_HR" \
"$(OUTPUT_DIR)\locale\hu_HU" \
"$(OUTPUT_DIR)\locale\is_IS" \
"$(OUTPUT_DIR)\locale\it_IT" \
"$(OUTPUT_DIR)\locale\lt_LT" \
"$(OUTPUT_DIR)\locale\nb_NO" \
"$(OUTPUT_DIR)\locale\nl_NL" \
"$(OUTPUT_DIR)\locale\pl_PL" \
"$(OUTPUT_DIR)\locale\pt_PT" \
"$(OUTPUT_DIR)\locale\ru_RU" \
"$(OUTPUT_DIR)\locale\sk_SK" \
"$(OUTPUT_DIR)\locale\sl_SI" \
"$(OUTPUT_DIR)\locale\sr_RS" \
"$(OUTPUT_DIR)\locale\sv_SE" \
"$(OUTPUT_DIR)\locale\tr_TR" \
"$(OUTPUT_DIR)\locale\vi_VN" \
"$(OUTPUT_DIR)\Setup" \
"$(PUBLISH_PACKAGE_DIR)" \
"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" :
	if not exist $@ md $@

"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\Setup" : "$(OUTPUT_DIR)"

"$(OUTPUT_DIR)\locale\bg_BG" \
"$(OUTPUT_DIR)\locale\ca_ES" \
"$(OUTPUT_DIR)\locale\cs_CZ" \
"$(OUTPUT_DIR)\locale\cy_UK" \
"$(OUTPUT_DIR)\locale\de_DE" \
"$(OUTPUT_DIR)\locale\el_GR" \
"$(OUTPUT_DIR)\locale\es_ES" \
"$(OUTPUT_DIR)\locale\eu_ES" \
"$(OUTPUT_DIR)\locale\fi_FI" \
"$(OUTPUT_DIR)\locale\fr_CA" \
"$(OUTPUT_DIR)\locale\fr_FR" \
"$(OUTPUT_DIR)\locale\gl_ES" \
"$(OUTPUT_DIR)\locale\hr_HR" \
"$(OUTPUT_DIR)\locale\hu_HU" \
"$(OUTPUT_DIR)\locale\is_IS" \
"$(OUTPUT_DIR)\locale\it_IT" \
"$(OUTPUT_DIR)\locale\lt_LT" \
"$(OUTPUT_DIR)\locale\nb_NO" \
"$(OUTPUT_DIR)\locale\nl_NL" \
"$(OUTPUT_DIR)\locale\pl_PL" \
"$(OUTPUT_DIR)\locale\pt_PT" \
"$(OUTPUT_DIR)\locale\ru_RU" \
"$(OUTPUT_DIR)\locale\sk_SK" \
"$(OUTPUT_DIR)\locale\sl_SI" \
"$(OUTPUT_DIR)\locale\sr_RS" \
"$(OUTPUT_DIR)\locale\sv_SE" \
"$(OUTPUT_DIR)\locale\tr_TR" \
"$(OUTPUT_DIR)\locale\vi_VN" : "$(OUTPUT_DIR)\locale"


######################################################################
# File copy
######################################################################

$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)32.msi : "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"
	copy /y $** $@ > NUL

"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)64.msi" : "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" : "$(OUTPUT_DIR)\Win32.Release\CredWrite.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" \
"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe" : "$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\WLANManager.exe" \
"$(PUBLISH_PACKAGE_DIR)\WLANManager.exe" : "$(OUTPUT_DIR)\Win32.Release\WLANManager.exe"
	copy /y $** $@ > NUL


######################################################################
# Shortcut creation
######################################################################

"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk" : "$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"
	cscript.exe "bin\MkLnk.wsf" //Nologo $@ "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"


######################################################################
# Building
######################################################################

"$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo" : "$(WXWIN)\locale\ca.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo" : "$(WXWIN)\locale\cs.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\de_DE\wxstd.mo" : "$(WXWIN)\locale\de.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\el_GR\wxstd.mo" : "$(WXWIN)\locale\el.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\es_ES\wxstd.mo" : "$(WXWIN)\locale\es.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo" : "$(WXWIN)\locale\eu.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo" : "$(WXWIN)\locale\fi.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo" : "$(WXWIN)\locale\fr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo" : "$(WXWIN)\locale\fr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo" : "$(WXWIN)\locale\gl_ES.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo" : "$(WXWIN)\locale\hu.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\it_IT\wxstd.mo" : "$(WXWIN)\locale\it.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo" : "$(WXWIN)\locale\lt.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo" : "$(WXWIN)\locale\nb.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo" : "$(WXWIN)\locale\nl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo" : "$(WXWIN)\locale\pl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo" : "$(WXWIN)\locale\pt.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo" : "$(WXWIN)\locale\ru.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo" : "$(WXWIN)\locale\sk.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo" : "$(WXWIN)\locale\sl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo" : "$(WXWIN)\locale\sv.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo" : "$(WXWIN)\locale\tr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo" : "$(WXWIN)\locale\vi.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\Win32.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Release\Events.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.2.msi" :: Localization
	devenv.com "VS10Solution.sln" /build "Release|Win32"

"$(OUTPUT_DIR)\Win32.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Debug\Events.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.2.msi" :: Localization
	devenv.com "VS10Solution.sln" /build "Debug|Win32"

"$(OUTPUT_DIR)\x64.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Release\Events.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.2.msi" :: Localization
	devenv.com "VS10Solution.sln" /build "Release|x64"

"$(OUTPUT_DIR)\x64.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Debug\Events.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.2.msi" :: Localization
	devenv.com "VS10Solution.sln" /build "Debug|x64"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=En PLAT=Win32 CFG=Release
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=En PLAT=Win32 CFG=Debug
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=En PLAT=x64 CFG=Release
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" ::
	cd "MSI\Base"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) LANG=En PLAT=x64 CFG=Debug
	cd "$(MAKEDIR)"

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)32" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)64" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	-if exist $@ del /f /q $@
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetCAB //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.3.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.3.mst"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.3.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.3.mst" 1026
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.3.mst" 1027
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.3.mst" 1029
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.3.mst" 0
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.3.mst" 1031
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.3.mst" 1032
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.3.mst" 1034
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.3.mst" 1069
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.3.mst" 1035
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.3.mst" 3084
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.3.mst" 1036
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.3.mst" 1110
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.3.mst" 1050
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.3.mst" 1038
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.3.mst" 1039
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.3.mst" 1040
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.3.mst" 1063
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.3.mst" 1044
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.3.mst" 1043
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.3.mst" 1045
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.3.mst" 2070
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.3.mst" 1049
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.3.mst" 1051
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.3.mst" 1060
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.3.mst" 2074
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.3.mst" 1053
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.3.mst" 1055
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.3.mst" 1066
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetLangMST //Nologo "$(@:"=).tmp" 1033 1026 1027 1029 1031 1032 1034 1069 1035 3084 1036 1110 1050 1038 1039 1040 1063 1044 1043 1045 2070 1049 1051 1060 2074 1053 1055 1066"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.3.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.3.mst"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.3.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.3.mst" 1026
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.3.mst" 1027
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.3.mst" 1029
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.3.mst" 0
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.3.mst" 1031
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.3.mst" 1032
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.3.mst" 1034
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.3.mst" 1069
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.3.mst" 1035
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.3.mst" 3084
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.3.mst" 1036
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.3.mst" 1110
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.3.mst" 1050
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.3.mst" 1038
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.3.mst" 1039
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.3.mst" 1040
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.3.mst" 1063
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.3.mst" 1044
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.3.mst" 1043
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.3.mst" 1045
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.3.mst" 2070
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.3.mst" 1049
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.3.mst" 1051
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.3.mst" 1060
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.3.mst" 2074
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.3.mst" 1053
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.3.mst" 1055
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.3.mst" 1066
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetLangMST //Nologo "$(@:"=).tmp" 1033 1026 1027 1029 1031 1032 1034 1069 1035 3084 1036 1110 1050 1038 1039 1040 1063 1044 1043 1045 2070 1049 1051 1060 2074 1053 1055 1066"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.3.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.3.mst"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.3.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.3.mst" 1026
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.3.mst" 1027
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.3.mst" 1029
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.3.mst" 0
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.3.mst" 1031
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.3.mst" 1032
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.3.mst" 1034
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.3.mst" 1069
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.3.mst" 1035
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.3.mst" 3084
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.3.mst" 1036
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.3.mst" 1110
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.3.mst" 1050
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.3.mst" 1038
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.3.mst" 1039
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.3.mst" 1040
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.3.mst" 1063
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.3.mst" 1044
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.3.mst" 1043
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.3.mst" 1045
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.3.mst" 2070
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.3.mst" 1049
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.3.mst" 1051
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.3.mst" 1060
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.3.mst" 2074
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.3.mst" 1053
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.3.mst" 1055
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.3.mst" 1066
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetLangMST //Nologo "$(@:"=).tmp" 1033 1026 1027 1029 1031 1032 1034 1069 1035 3084 1036 1110 1050 1038 1039 1040 1063 1044 1043 1045 2070 1049 1051 1060 2074 1053 1055 1066"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.3.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.3.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.3.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.3.mst"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.3.msi" "$(@:"=).tmp" > NUL
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.3.mst" 1026
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.3.mst" 1027
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.3.mst" 1029
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.3.mst" 0
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.3.mst" 1031
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.3.mst" 1032
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.3.mst" 1034
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.3.mst" 1069
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.3.mst" 1035
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.3.mst" 3084
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.3.mst" 1036
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.3.mst" 1110
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.3.mst" 1050
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.3.mst" 1038
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.3.mst" 1039
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.3.mst" 1040
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.3.mst" 1063
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.3.mst" 1044
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.3.mst" 1043
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.3.mst" 1045
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.3.mst" 2070
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.3.mst" 1049
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.3.mst" 1051
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.3.mst" 1060
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.3.mst" 2074
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.3.mst" 1053
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.3.mst" 1055
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.3.mst" 1066
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:SetLangMST //Nologo "$(@:"=).tmp" 1033 1026 1027 1029 1031 1032 1034 1069 1035 3084 1036 1110 1050 1038 1039 1040 1063 1044 1043 1045 2070 1049 1051 1060 2074 1053 1055 1066"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.3.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.3.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.3.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.3.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.3.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

!ENDIF

LANG=bg_BG
!INCLUDE "MSILocal.mak"

LANG=ca_ES
!INCLUDE "MSILocal.mak"

LANG=cs_CZ
!INCLUDE "MSILocal.mak"

#LANG=cy_UK
#!INCLUDE "MSILocal.mak"

LANG=de_DE
!INCLUDE "MSILocal.mak"

LANG=el_GR
!INCLUDE "MSILocal.mak"

LANG=es_ES
!INCLUDE "MSILocal.mak"

LANG=eu_ES
!INCLUDE "MSILocal.mak"

LANG=fi_FI
!INCLUDE "MSILocal.mak"

LANG=fr_FR
!INCLUDE "MSILocal.mak"

LANG=fr_CA
!INCLUDE "MSILocal.mak"

LANG=gl_ES
!INCLUDE "MSILocal.mak"

LANG=hr_HR
!INCLUDE "MSILocal.mak"

LANG=hu_HU
!INCLUDE "MSILocal.mak"

LANG=is_IS
!INCLUDE "MSILocal.mak"

LANG=it_IT
!INCLUDE "MSILocal.mak"

LANG=lt_LT
!INCLUDE "MSILocal.mak"

LANG=nb_NO
!INCLUDE "MSILocal.mak"

LANG=nl_NL
!INCLUDE "MSILocal.mak"

LANG=pl_PL
!INCLUDE "MSILocal.mak"

LANG=pt_PT
!INCLUDE "MSILocal.mak"

LANG=ru_RU
!INCLUDE "MSILocal.mak"

LANG=sk_SK
!INCLUDE "MSILocal.mak"

LANG=sl_SI
!INCLUDE "MSILocal.mak"

LANG=sr_RS
!INCLUDE "MSILocal.mak"

LANG=sv_SE
!INCLUDE "MSILocal.mak"

LANG=tr_TR
!INCLUDE "MSILocal.mak"

LANG=vi_VN
!INCLUDE "MSILocal.mak"
