/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

#define _CRT_SECURE_NO_WARNINGS

#pragma once

#include "../../include/Version.h"

#include "../include/EAP.h"
#include "../include/EAP_UI.h"
#include "../include/EAPSerial.h"
#include "../include/TLS.h"
#include "../include/TLS_UI.h"
#include "../include/TTLS.h"
#include "../include/TTLS_UI.h"
#include "../include/EAPXML.h"
#include "../include/PAP.h"

#include "../res/wxTLS_UI.h"
#include "../res/wxTTLS_UI.h"

#include <WinStd/ETW.h>
#include <WinStd/Win.h>

#include <wx/app.h>
#include <wx/init.h>
#include <wx/msgdlg.h>

#include <eaptypes.h>
#include <eapmethodpeerapis.h>

#include <Commctrl.h>
#include <Msi.h>
#include <tchar.h>
#include <Shlwapi.h>
#include <Windows.h>

#include <EAPMethodETW.h>

#pragma comment(lib, "Crypt32.lib")
