﻿///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Jun 17 2015)
// http://www.wxformbuilder.org/
//
// PLEASE DO "NOT" EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#include "StdAfx.h"

#include "../ETWLog.h"

#include "wxEventMonitor_UI.h"

///////////////////////////////////////////////////////////////////////////

wxEventMonitorLogPanelBase::wxEventMonitorLogPanelBase( wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name ) : wxPanel( parent, id, pos, size, style, name )
{
	wxBoxSizer* bSizerMain;
	bSizerMain = new wxBoxSizer( wxVERTICAL );
	
	m_log = new wxETWListCtrl( this, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxLC_NO_SORT_HEADER|wxLC_REPORT|wxLC_VIRTUAL|wxNO_BORDER, wxDefaultValidator, wxT("EventMonitorLog") );
	bSizerMain->Add( m_log, 1, wxEXPAND, 5 );
	
	
	this->SetSizer( bSizerMain );
	this->Layout();
	bSizerMain->Fit( this );
}

wxEventMonitorLogPanelBase::~wxEventMonitorLogPanelBase()
{
}
