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

#include <WinStd/Crypt.h>
#include <WinStd/ETW.h>
#include <WinStd/Win.h>

#include <eaptypes.h>
extern "C" {
#include <eapmethodpeerapis.h>
}

#include <list>

#include <EAPMethodETW.h>
#include <EAPSerialize.h>

///
/// EAP method numbers
///
/// \sa [Extensible Authentication Protocol (EAP) Registry (Chapter: Method Types)](https://www.iana.org/assignments/eap-numbers/eap-numbers.xhtml#eap-numbers-4)
///
#define EAP_TYPE_TTLS            21
#define EAP_TYPE_PEAP            25
#define EAP_TYPE_MSCHAPV2        26
#define EAP_TYPE_PAP             192 // Not actually an EAP method (moved to the Unassigned area)


namespace eap
{
    class session;

    class config;
    class config_pass;
    class config_tls;

    class module;
    class peer;
    class peer_ui;
}

namespace eapserial
{
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config &val);
    inline size_t get_pk_size(const eap::config &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config &val);

    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_pass &val);
    inline size_t get_pk_size(const eap::config_pass &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_pass &val);

    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_tls &val);
    inline size_t get_pk_size(const eap::config_tls &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_tls &val);
}

extern HINSTANCE g_hResource;

#pragma once


#define ETW_ERROR(kw, f, ...)   m_ep.write(TRACE_LEVEL_ERROR      , kw, _T(__FUNCTION__) _T(" ") f, ##__VA_ARGS__)
#define ETW_WARNING(kw, f, ...) m_ep.write(TRACE_LEVEL_WARNING    , kw, _T(__FUNCTION__) _T(" ") f, ##__VA_ARGS__)
#define ETW_INFO(kw, f, ...)    m_ep.write(TRACE_LEVEL_INFORMATION, kw, _T(__FUNCTION__) _T(" ") f, ##__VA_ARGS__)
#define ETW_VERBOSE(kw, f, ...) m_ep.write(TRACE_LEVEL_VERBOSE    , kw, _T(__FUNCTION__) _T(" ") f, ##__VA_ARGS__)
#define ETW_FN_VOID             winstd::event_fn_auto    <         &EAPMETHOD_TRACE_EVT_FN_CALL, &EAPMETHOD_TRACE_EVT_FN_RETURN        > _event_auto(m_ep, __FUNCTION__)
#define ETW_FN_DWORD(res)       winstd::event_fn_auto_ret<DWORD  , &EAPMETHOD_TRACE_EVT_FN_CALL, &EAPMETHOD_TRACE_EVT_FN_RETURN_DWORD  > _event_auto(m_ep, __FUNCTION__, res)
#define ETW_FN_HRESULT(res)     winstd::event_fn_auto_ret<HRESULT, &EAPMETHOD_TRACE_EVT_FN_CALL, &EAPMETHOD_TRACE_EVT_FN_RETURN_HRESULT> _event_auto(m_ep, __FUNCTION__, res)


namespace eap
{
    ///
    /// EAP session
    ///
    class session
    {
    public:
        ///
        /// Constructor
        ///
        session();
        virtual ~session();

        ///
        /// Starts an EAP authentication session on the peer EAPHost using the EAP method.
        ///
        /// \sa [EapPeerBeginSession function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363600.aspx)
        ///
        virtual DWORD begin(
            _In_                                   DWORD         dwFlags,
            _In_                             const EapAttributes *pAttributeArray,
            _In_                                   HANDLE        hTokenImpersonateUser,
            _In_                                   DWORD         dwConnectionDataSize,
            _In_count_(dwConnectionDataSize) const BYTE          *pConnectionData,
            _In_                                   DWORD         dwUserDataSize,
            _In_count_(dwUserDataSize)       const BYTE          *pUserData,
            _In_                                   DWORD         dwMaxSendPacketSize,
            _Out_                                  EAP_ERROR     **ppEapError);

        ///
        /// Ends an EAP authentication session for the EAP method.
        ///
        /// \sa [EapPeerEndSession function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363604.aspx)
        ///
        virtual DWORD end(_Out_ EAP_ERROR **ppEapError);

        ///
        /// Processes a packet received by EAPHost from a supplicant.
        ///
        /// \sa [EapPeerProcessRequestPacket function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363621.aspx)
        ///
        virtual DWORD process_request_packet(
            _In_                                       DWORD               dwReceivedPacketSize,
            _In_bytecount_(dwReceivedPacketSize) const EapPacket           *pReceivedPacket,
            _Out_                                      EapPeerMethodOutput *pEapOutput,
            _Out_                                      EAP_ERROR           **ppEapError);

        ///
        /// Obtains a response packet from the EAP method.
        ///
        /// \sa [EapPeerGetResponsePacket function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363610.aspx)
        ///
        virtual DWORD get_response_packet(
            _Inout_                            DWORD              *pdwSendPacketSize,
            _Inout_bytecap_(*dwSendPacketSize) EapPacket          *pSendPacket,
            _Out_                              EAP_ERROR          **ppEapError);

        ///
        /// Obtains the result of an authentication session from the EAP method.
        ///
        /// \sa [EapPeerGetResult function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363611.aspx)
        ///
        virtual DWORD get_result(_In_ EapPeerMethodResultReason reason, _Out_ EapPeerMethodResult *ppResult, _Out_ EAP_ERROR **ppEapError);

        ///
        /// Obtains the user interface context from the EAP method.
        ///
        /// \note This function is always followed by the `EapPeerInvokeInteractiveUI()` function, which is followed by the `EapPeerSetUIContext()` function.
        ///
        /// \sa [EapPeerGetUIContext function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363612.aspx)
        ///
        virtual DWORD get_ui_context(
            _Out_ DWORD     *pdwUIContextDataSize,
            _Out_ BYTE      **ppUIContextData,
            _Out_ EAP_ERROR **ppEapError);

        ///
        /// Provides a user interface context to the EAP method.
        ///
        /// \note This function is called after the UI has been raised through the `EapPeerGetUIContext()` function.
        ///
        /// \sa [EapPeerSetUIContext function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363626.aspx)
        ///
        virtual DWORD set_ui_context(
            _In_                                  DWORD               dwUIContextDataSize,
            _In_count_(dwUIContextDataSize) const BYTE                *pUIContextData,
            _In_                            const EapPeerMethodOutput *pEapOutput,
            _Out_                                 EAP_ERROR           **ppEapError);

        ///
        /// Obtains an array of EAP response attributes from the EAP method.
        ///
        /// \sa [EapPeerGetResponseAttributes function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363609.aspx)
        ///
        virtual DWORD get_response_attributes(_Out_ EapAttributes *pAttribs, _Out_ EAP_ERROR **ppEapError);

        ///
        /// Provides an updated array of EAP response attributes to the EAP method.
        ///
        /// \sa [EapPeerSetResponseAttributes function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363625.aspx)
        ///
        virtual DWORD set_response_attributes(const _In_ EapAttributes *pAttribs, _Out_ EapPeerMethodOutput *pEapOutput, _Out_ EAP_ERROR **ppEapError);
    };


    // config classes do not need an assignment operator actually, so the C4512 warning is safely ignored.
    #pragma warning(push)
    #pragma warning(disable: 4512)

    ///
    /// Base class for configuration storage
    ///
    class config
    {
    public:
        config(_In_ module &mod);
        virtual ~config();
        virtual DWORD save(_In_ IXMLDOMDocument2 *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);

    public:
        module &m_module;   ///< Reference of the EAP module
    };


    ///
    /// Configuration for password based methods
    ///
    class config_pass : public config
    {
    public:
        config_pass(_In_ module &mod);
        virtual DWORD save(_In_ IXMLDOMDocument2 *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);

    public:
        std::wstring m_realm;                   ///< Windows Credential Storage realm
        winstd::tstring m_lbl_alt_credential;   ///< Alternative label for credential prompt
        winstd::tstring m_lbl_alt_identity;     ///< Alternative label for identity prompt
        winstd::tstring m_lbl_alt_password;     ///< Alternative label for password prompt
    };


    ///
    /// Configuration for TLS based methods
    ///
    class config_tls : public config
    {
    public:
        config_tls(_In_ module &mod);
        virtual DWORD save(_In_ IXMLDOMDocument2 *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);

        bool add_trusted_ca(_In_  DWORD dwCertEncodingType, _In_  const BYTE *pbCertEncoded, _In_  DWORD cbCertEncoded);

    public:
        std::list<winstd::cert_context> m_trusted_root_ca;    ///< Trusted root CAs
        std::list<std::string> m_server_names;                ///< Acceptable authenticating server names
    };

    #pragma warning(pop)


    ///
    /// EAP module base class
    ///
    class module
    {
    public:
        module();
        virtual ~module();

        ///
        /// Allocate a EAP_ERROR and fill it according to dwErrorCode
        ///
        EAP_ERROR* make_error(_In_ DWORD dwErrorCode, _In_ DWORD dwReasonCode, _In_ LPCGUID pRootCauseGuid, _In_ LPCGUID pRepairGuid, _In_ LPCGUID pHelpLinkGuid, _In_z_ LPCWSTR pszRootCauseString, _In_z_ LPCWSTR pszRepairString) const;

        ///
        /// Allocate BLOB
        ///
        virtual BYTE* alloc_memory(_In_ size_t size);

        ///
        /// Free BLOB allocated with this peer
        ///
        virtual void free_memory(_In_ BYTE *ptr);

        ///
        /// Free EAP_ERROR allocated with `make_error()` method
        ///
        virtual void free_error_memory(_In_ EAP_ERROR *err);

    protected:
        winstd::heap m_heap;                    ///< Heap
        mutable winstd::event_provider m_ep;    ///< Event Provider
    };


    ///
    /// EAP peer base class
    ///
    class peer : public module
    {
    public:
        peer();

        ///
        /// Initializes an EAP peer method for EAPHost.
        ///
        /// \sa [EapPeerGetInfo function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363613.aspx)
        ///
        virtual DWORD initialize(_Out_ EAP_ERROR **ppEapError);

        ///
        /// Shuts down the EAP method and prepares to unload its corresponding DLL.
        ///
        /// \sa [EapPeerShutdown function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363627.aspx)
        ///
        virtual DWORD shutdown(_Out_ EAP_ERROR **ppEapError);

        ///
        /// Returns the user data and user identity after being called by EAPHost.
        ///
        /// \sa [EapPeerGetIdentity function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363607.aspx)
        ///
        virtual DWORD get_identity(
            _In_                                   DWORD     dwFlags,
            _In_                                   DWORD     dwConnectionDataSize,
            _In_count_(dwConnectionDataSize) const BYTE      *pConnectionData,
            _In_                                   DWORD     dwUserDataSize,
            _In_count_(dwUserDataSize)       const BYTE      *pUserData,
            _In_                                   HANDLE    hTokenImpersonateUser,
            _Out_                                  BOOL      *pfInvokeUI,
            _Out_                                  DWORD     *pdwUserDataOutSize,
            _Out_                                  BYTE      **ppUserDataOut,
            _Out_                                  WCHAR     **ppwszIdentity,
            _Out_                                  EAP_ERROR **ppEapError);

        ///
        /// Defines the implementation of an EAP method-specific function that retrieves the properties of an EAP method given the connection and user data.
        ///
        /// \sa [EapPeerGetMethodProperties function](https://msdn.microsoft.com/en-us/library/windows/desktop/hh706636.aspx)
        ///
        virtual DWORD get_method_properties(
            _In_                                DWORD                     dwVersion,
            _In_                                DWORD                     dwFlags,
            _In_                                HANDLE                    hUserImpersonationToken,
            _In_                                DWORD                     dwEapConnDataSize,
            _In_count_(dwEapConnDataSize) const BYTE                      *pEapConnData,
            _In_                                DWORD                     dwUserDataSize,
            _In_count_(dwUserDataSize)    const BYTE                      *pUserData,
            _Out_                               EAP_METHOD_PROPERTY_ARRAY *pMethodPropertyArray,
            _Out_                               EAP_ERROR                 **ppEapError) const;

        ///
        /// Converts XML into the configuration BLOB. The XML based credentials can come from group policy or from a system administrator.
        ///
        /// \sa [EapPeerCredentialsXml2Blob function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363603.aspx)
        ///
        virtual DWORD credentials_xml_to_blob(
            _In_                             DWORD            dwFlags,
            _In_                             IXMLDOMDocument2 *pCredentialsDoc,
            _In_count_(dwConfigInSize) const BYTE             *pConfigIn,
            _In_                             DWORD            dwConfigInSize,
            _Out_                            BYTE             **ppCredentialsOut,
            _Out_                            DWORD            *pdwCredentialsOutSize,
            _Out_                            EAP_ERROR        **ppEapError) const;

        ///
        /// Defines the implementation of an EAP method-specific function that obtains the EAP Single-Sign-On (SSO) credential input fields for an EAP method.
        ///
        /// \sa [EapPeerQueryCredentialInputFields function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363622.aspx)
        ///
        virtual DWORD query_credential_input_fields(
            _In_                                HANDLE                       hUserImpersonationToken,
            _In_                                DWORD                        dwFlags,
            _In_                                DWORD                        dwEapConnDataSize,
            _In_count_(dwEapConnDataSize) const BYTE                         *pEapConnData,
            _Out_                               EAP_CONFIG_INPUT_FIELD_ARRAY *pEapConfigInputFieldsArray,
            _Out_                               EAP_ERROR                    **ppEapError) const;

        ///
        /// Defines the implementation of an EAP method function that obtains the user BLOB data provided in an interactive Single-Sign-On (SSO) UI raised on the supplicant.
        ///
        /// \sa [EapPeerQueryUserBlobFromCredentialInputFields function](https://msdn.microsoft.com/en-us/library/windows/desktop/bb204697.aspx)
        ///
        virtual DWORD query_user_blob_from_credential_input_fields(
            _In_                                HANDLE                       hUserImpersonationToken,
            _In_                                DWORD                        dwFlags,
            _In_                                DWORD                        dwEapConnDataSize,
            _In_count_(dwEapConnDataSize) const BYTE                         *pEapConnData,
            _In_                          const EAP_CONFIG_INPUT_FIELD_ARRAY *pEapConfigInputFieldArray,
            _Inout_                             DWORD                        *pdwUsersBlobSize,
            _Inout_                             BYTE                         **ppUserBlob,
            _Out_                               EAP_ERROR                    **ppEapError) const;

        ///
        /// Defines the implementation of an EAP method API that provides the input fields for interactive UI components to be raised on the supplicant.
        ///
        /// \sa [EapPeerQueryInteractiveUIInputFields function](https://msdn.microsoft.com/en-us/library/windows/desktop/bb204695.aspx)
        ///
        virtual DWORD query_interactive_ui_input_fields(
            _In_                                  DWORD                   dwVersion,
            _In_                                  DWORD                   dwFlags,
            _In_                                  DWORD                   dwUIContextDataSize,
            _In_count_(dwUIContextDataSize) const BYTE                    *pUIContextData,
            _Out_                                 EAP_INTERACTIVE_UI_DATA *pEapInteractiveUIData,
            _Out_                                 EAP_ERROR               **ppEapError,
            _Inout_                               LPVOID                  *pvReserved) const;

        ///
        /// Converts user information into a user BLOB that can be consumed by EAPHost run-time functions.
        ///
        /// \sa [EapPeerQueryUIBlobFromInteractiveUIInputFields function](https://msdn.microsoft.com/en-us/library/windows/desktop/bb204696.aspx)
        ///
        virtual DWORD query_ui_blob_from_interactive_ui_input_fields(
            _In_                                  DWORD                   dwVersion,
            _In_                                  DWORD                   dwFlags,
            _In_                                  DWORD                   dwUIContextDataSize,
            _In_count_(dwUIContextDataSize) const BYTE                    *pUIContextData,
            _In_                            const EAP_INTERACTIVE_UI_DATA *pEapInteractiveUIData,
            _Out_                                 DWORD                   *pdwDataFromInteractiveUISize,
            _Out_                                 BYTE                    **ppDataFromInteractiveUI,
            _Out_                                 EAP_ERROR               **ppEapError,
            _Inout_                               LPVOID                  *ppvReserved) const;
    };


    ///
    /// EAP peer UI base class
    ///
    class peer_ui : public module
    {
    public:
        ///
        /// Constructor
        ///
        peer_ui();

        ///
        /// Converts XML into the configuration BLOB.
        ///
        /// \sa [EapPeerConfigXml2Blob function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363602.aspx)
        ///
        virtual DWORD config_xml_to_blob(
            _In_  DWORD            dwFlags,
            _In_  IXMLDOMDocument2 *pConfigDoc,
            _Out_ BYTE             **ppConfigOut,
            _Out_ DWORD            *pdwConfigOutSize,
            _Out_ EAP_ERROR        **ppEapError) = 0;

        ///
        /// Converts the configuration BLOB to XML.
        ///
        /// The configuration BLOB is returned in the ppConnectionDataOut parameter of the EapPeerInvokeConfigUI function.
        ///
        /// \sa [EapPeerConfigBlob2Xml function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363601.aspx)
        ///
        virtual DWORD config_blob_to_xml(
            _In_                             DWORD            dwFlags,
            _In_count_(dwConfigInSize) const BYTE             *pConfigIn,
            _In_                             DWORD            dwConfigInSize,
            _Out_                            IXMLDOMDocument2 **ppConfigDoc,
            _Out_                            EAP_ERROR        **ppEapError) = 0;

        ///
        /// Raises the EAP method's specific connection configuration user interface dialog on the client.
        ///
        /// \sa [EapPeerInvokeConfigUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363614.aspx)
        ///
        virtual DWORD invoke_config_ui(
            _In_                                     HWND            hwndParent,
            _In_                                     DWORD           dwFlags,
            _In_                                     DWORD           dwConnectionDataInSize,
            _In_count_(dwConnectionDataInSize) const BYTE            *pConnectionDataIn,
            _Out_                                    DWORD           *pdwConnectionDataOutSize,
            _Out_                                    BYTE            **ppConnectionDataOut,
            _Out_                                    EAP_ERROR       **ppEapError) = 0;

        ///
        /// Raises a custom interactive user interface dialog to obtain user identity information for the EAP method on the client.
        ///
        /// \sa [EapPeerInvokeIdentityUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363615.aspx)
        ///
        virtual DWORD invoke_identity_ui(
            _In_                                   DWORD           dwFlags,
            _In_                                   HWND            hwndParent,
            _In_                                   DWORD           dwConnectionDataSize,
            _In_count_(dwConnectionDataSize) const BYTE            *pConnectionData,
            _In_                                   DWORD           dwUserDataSize,
            _In_count_(dwUserDataSize)       const BYTE            *pUserData,
            _Out_                                  DWORD           *pdwUserDataOutSize,
            _Out_                                  BYTE            **ppUserDataOut,
            _Out_                                  LPWSTR          *ppwszIdentity,
            _Out_                                  EAP_ERROR       **ppEapError) = 0;

        ///
        /// Raises a custom interactive user interface dialog for the EAP method on the client.
        ///
        /// \sa [EapPeerInvokeInteractiveUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363616.aspx)
        ///
        virtual DWORD invoke_interactive_ui(
            _In_                                  HWND            hwndParent,
            _In_                                  DWORD           dwUIContextDataSize,
            _In_count_(dwUIContextDataSize) const BYTE            *pUIContextData,
            _Out_                                 DWORD           *pdwDataFromInteractiveUISize,
            _Out_                                 BYTE            **ppDataFromInteractiveUI,
            _Out_                                 EAP_ERROR       **ppEapError) = 0;
    };
}


namespace eapserial
{
    ///
    /// Packs a method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config &val)
    {
        UNREFERENCED_PARAMETER(cursor);
        UNREFERENCED_PARAMETER(val);
    }


    ///
    /// Returns packed size of a method configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    inline size_t get_pk_size(const eap::config &val)
    {
        UNREFERENCED_PARAMETER(val);
        return 0;
    }


    ///
    /// Unpacks a method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config &val)
    {
        UNREFERENCED_PARAMETER(cursor);
        UNREFERENCED_PARAMETER(val);
    }


    ///
    /// Packs a password based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_pass &val)
    {
        pack(cursor, (const eap::config&)val );
        pack(cursor, val.m_realm             );
        pack(cursor, val.m_lbl_alt_credential);
        pack(cursor, val.m_lbl_alt_identity  );
        pack(cursor, val.m_lbl_alt_password  );
    }


    ///
    /// Returns packed size of a password based method configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    inline size_t get_pk_size(const eap::config_pass &val)
    {
        // Note: Parent eap::config has no data.
        return
            get_pk_size((const eap::config&)val ) +
            get_pk_size(val.m_realm             ) +
            get_pk_size(val.m_lbl_alt_credential) +
            get_pk_size(val.m_lbl_alt_identity  ) +
            get_pk_size(val.m_lbl_alt_password  );
    }


    ///
    /// Unpacks a password based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_pass &val)
    {
        unpack(cursor, (eap::config&)val       );
        unpack(cursor, val.m_realm             );
        unpack(cursor, val.m_lbl_alt_credential);
        unpack(cursor, val.m_lbl_alt_identity  );
        unpack(cursor, val.m_lbl_alt_password  );
    }


    ///
    /// Packs a TLS based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_tls &val)
    {
        pack(cursor, (const eap::config&)val);
        pack(cursor, val.m_trusted_root_ca  );
        pack(cursor, val.m_server_names     );
    }


    ///
    /// Returns packed size of a TLS based method configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    inline size_t get_pk_size(const eap::config_tls &val)
    {
        return
            get_pk_size((const eap::config&)val) +
            get_pk_size(val.m_trusted_root_ca  ) +
            get_pk_size(val.m_server_names     );
    }


    ///
    /// Unpacks a TLS based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_tls &val)
    {
        unpack(cursor, (eap::config&)val    );
        unpack(cursor, val.m_trusted_root_ca);
        unpack(cursor, val.m_server_names   );
    }
}
