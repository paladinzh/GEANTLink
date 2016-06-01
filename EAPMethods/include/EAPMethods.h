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

#include <tchar.h>
#include <list>
#include <utility>

#include <EAPMethodETW.h>
#include <EAPSerialize.h>


namespace eap
{
    enum type_t;

    class session;

    class config;
    class config_method;
    class config_pass;
    class config_tls;
    template <class _Tmeth> class config_provider;
    template <class _Tprov> class config_providers;

    class module;
    class peer;
    template <class _Tcfg> class peer_ui;
}

namespace eapserial
{
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_method &val);
    inline size_t get_pk_size(const eap::config_method &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_method &val);

    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_pass &val);
    inline size_t get_pk_size(const eap::config_pass &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_pass &val);

    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_tls &val);
    inline size_t get_pk_size(const eap::config_tls &val);
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_tls &val);

    template <class _Tmeth> inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_provider<_Tmeth> &val);
    template <class _Tmeth> inline size_t get_pk_size(const eap::config_provider<_Tmeth> &val);
    template <class _Tmeth> inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_provider<_Tmeth> &val);

    template <class _Tprov> inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_providers<_Tprov> &val);
    template <class _Tprov> inline size_t get_pk_size(const eap::config_providers<_Tprov> &val);
    template <class _Tprov> inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_providers<_Tprov> &val);
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
    /// EAP method numbers
    ///
    /// \sa [Extensible Authentication Protocol (EAP) Registry (Chapter: Method Types)](https://www.iana.org/assignments/eap-numbers/eap-numbers.xhtml#eap-numbers-4)
    ///
    enum type_t {
        type_ttls     = 21,
        type_peap     = 25,
        type_mschapv2 = 26,
        type_pap      = 192, // Not actually an EAP method (moved to the Unassigned area)
    };


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


    ///
    /// Base class for configuration storage
    ///
    class config
    {
    public:
        config(_In_ module &mod);
        config(_In_ const config &other);
        config(_Inout_ config &&other);
        virtual ~config();

        config& operator=(_In_ const config &other);
        config& operator=(_Inout_ config &&other);

        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const = 0;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) = 0;

    public:
        module &m_module;   ///< Reference of the EAP module
    };


    ///
    /// Base class for method configuration storage
    ///
    class config_method : public config
    {
    public:
        config_method(_In_ module &mod);
        config_method(_In_ const config_method &other);
        config_method(_Inout_ config_method &&other);

        config_method& operator=(_In_ const config_method &other);
        config_method& operator=(_Inout_ config_method &&other);

        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);
        virtual eap::type_t get_method_id() = 0;

    public:
        bool m_allow_save;                      ///< Are credentials allowed to be saved to Windows Credential Storage?
        std::wstring m_anonymous_identity;      ///< Anonymous identity
    };


    ///
    /// Configuration for password based methods
    ///
    class config_pass : public config_method
    {
    public:
        config_pass(_In_ module &mod);
        config_pass(_In_ const config_pass &other);
        config_pass(_Inout_ config_pass &&other);

        config_pass& operator=(_In_ const config_pass &other);
        config_pass& operator=(_Inout_ config_pass &&other);

        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);

    public:
        std::wstring m_identity;                ///< Identity (user name)
        winstd::sanitizing_wstring m_password;  ///< Password
    };


    ///
    /// Configuration for TLS based methods
    ///
    class config_tls : public config_method
    {
    public:
        config_tls(_In_ module &mod);
        config_tls(_In_ const config_tls &other);
        config_tls(_Inout_ config_tls &&other);

        config_tls& operator=(_In_ const config_tls &other);
        config_tls& operator=(_Inout_ config_tls &&other);

        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const;
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError);

        bool add_trusted_ca(_In_  DWORD dwCertEncodingType, _In_  const BYTE *pbCertEncoded, _In_  DWORD cbCertEncoded);

    public:
        std::list<winstd::cert_context> m_trusted_root_ca;    ///< Trusted root CAs
        std::list<std::string> m_server_names;                ///< Acceptable authenticating server names
    };


    ///
    /// Provider configuration
    ///
    template <class _Tmeth>
    class config_provider : public config
    {
    public:
        config_provider(_In_ module &mod) : config(mod)
        {
        }

        config_provider(_In_ const config_provider &other) :
            m_id(other.m_id),
            m_lbl_alt_credential(other.m_lbl_alt_credential),
            m_lbl_alt_identity(other.m_lbl_alt_identity),
            m_lbl_alt_password(other.m_lbl_alt_password),
            m_methods(other.m_methods),
            config(other)
        {
        }

        config_provider(_Inout_ config_provider &&other) :
            m_id(std::move(other.m_id)),
            m_lbl_alt_credential(std::move(other.m_lbl_alt_credential)),
            m_lbl_alt_identity(std::move(other.m_lbl_alt_identity)),
            m_lbl_alt_password(std::move(other.m_lbl_alt_password)),
            m_methods(std::move(other.m_methods)),
            config(std::move(other))
        {
        }

        config_provider& operator=(_In_ const config_provider &other)
        {
            if (this != &other) {
                (config&)*this       = other;
                m_id                 = other.m_id;
                m_lbl_alt_credential = other.m_lbl_alt_credential;
                m_lbl_alt_identity   = other.m_lbl_alt_identity;
                m_lbl_alt_password   = other.m_lbl_alt_password;
                m_methods            = other.m_methods;
            }

            return *this;
        }

        config_provider& operator=(_Inout_ config_provider &&other)
        {
            if (this != &other) {
                (config&&)*this      = std::move(other);
                m_id                 = std::move(other.m_id);
                m_lbl_alt_credential = std::move(other.m_lbl_alt_credential);
                m_lbl_alt_identity   = std::move(other.m_lbl_alt_identity);
                m_lbl_alt_password   = std::move(other.m_lbl_alt_password);
                m_methods            = std::move(other.m_methods);
            }

            return *this;
        }

        ///
        /// Saves provider configuration to XML
        ///
        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const
        {
            const winstd::bstr bstrNamespace(L"urn:ietf:params:xml:ns:yang:ietf-eap-metadata");
            DWORD dwResult;
            HRESULT hr;

            // <ID>
            if (!m_id.empty())
                if ((dwResult = eapxml::put_element_value(pDoc, pConfigRoot, winstd::bstr(L"ID"), bstrNamespace, winstd::bstr(m_id))) != ERROR_SUCCESS) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <ID> element."), NULL);
                    return dwResult;
                }

            // <ProviderInfo>
            winstd::com_obj<IXMLDOMElement> pXmlElProviderInfo;
            if ((dwResult = eapxml::create_element(pDoc, pConfigRoot, winstd::bstr(L"eap-metadata:ProviderInfo"), winstd::bstr(L"ProviderInfo"), bstrNamespace, &pXmlElProviderInfo)) != ERROR_SUCCESS) {
                *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <ProviderInfo> element."), NULL);
                return dwResult;
            }

            // <ProviderInfo>/<CredentialPrompt>
            if (!m_lbl_alt_credential.empty())
                if ((dwResult = eapxml::put_element_value(pDoc, pXmlElProviderInfo, winstd::bstr(L"CredentialPrompt"), bstrNamespace, winstd::bstr(m_lbl_alt_credential))) != ERROR_SUCCESS) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <CredentialPrompt> element."), NULL);
                    return dwResult;
                }

            // <ProviderInfo>/<UserNameLabel>
            if (!m_lbl_alt_identity.empty())
                if ((dwResult = eapxml::put_element_value(pDoc, pXmlElProviderInfo, winstd::bstr(L"UserNameLabel"), bstrNamespace, winstd::bstr(m_lbl_alt_identity))) != ERROR_SUCCESS) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <UserNameLabel> element."), NULL);
                    return dwResult;
                }

            // <ProviderInfo>/<PasswordLabel>
            if (!m_lbl_alt_password.empty())
                if ((dwResult = eapxml::put_element_value(pDoc, pXmlElProviderInfo, winstd::bstr(L"PasswordLabel"), bstrNamespace, winstd::bstr(m_lbl_alt_password))) != ERROR_SUCCESS) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <PasswordLabel> element."), NULL);
                    return dwResult;
                }

            // <AuthenticationMethods>
            winstd::com_obj<IXMLDOMElement> pXmlElAuthenticationMethods;
            if ((dwResult = eapxml::create_element(pDoc, pConfigRoot, winstd::bstr(L"eap-metadata:AuthenticationMethods"), winstd::bstr(L"AuthenticationMethods"), bstrNamespace, &pXmlElAuthenticationMethods)) != ERROR_SUCCESS) {
                *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <AuthenticationMethods> element."), NULL);
                return dwResult;
            }

            for (std::list<_Tmeth>::const_iterator method = m_methods.cbegin(), method_end = m_methods.cend(); method != method_end; ++method) {
                // <AuthenticationMethod>
                winstd::com_obj<IXMLDOMElement> pXmlElAuthenticationMethod;
                if ((dwResult = eapxml::create_element(pDoc, winstd::bstr(L"AuthenticationMethod"), bstrNamespace, &pXmlElAuthenticationMethod))) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <AuthenticationMethod> element."), NULL);
                    return dwResult;
                }

                // <AuthenticationMethod>/...
                if ((dwResult = method->save(pDoc, pXmlElAuthenticationMethod, ppEapError)) != ERROR_SUCCESS)
                    return dwResult;

                if (FAILED(hr = pXmlElAuthenticationMethods->appendChild(pXmlElAuthenticationMethod, NULL))) {
                    *ppEapError = m_module.make_error(dwResult = HRESULT_CODE(hr), 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error appending <AuthenticationMethod> element."), NULL);
                    return dwResult;
                }
            }

            return dwResult;
        }


        ///
        /// Loads provider configuration from XML
        ///
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError)
        {
            assert(pConfigRoot);
            assert(ppEapError);
            DWORD dwResult;
            std::wstring lang;
            LoadString(g_hResource, 2, lang);

            // <ID>
            m_id.clear();
            eapxml::get_element_value(pConfigRoot, winstd::bstr(L"eap-metadata:ID"), m_id);

            // <ProviderInfo>
            m_lbl_alt_credential.clear();
            m_lbl_alt_identity.clear();
            m_lbl_alt_password.clear();
            winstd::com_obj<IXMLDOMElement> pXmlElProviderInfo;
            if (eapxml::select_element(pConfigRoot, winstd::bstr(L"eap-metadata:ProviderInfo"), &pXmlElProviderInfo) == ERROR_SUCCESS) {
                // <CredentialPrompt>
                eapxml::get_element_localized(pXmlElProviderInfo, winstd::bstr(L"eap-metadata:CredentialPrompt"), lang.c_str(), m_lbl_alt_credential);

                // <UserNameLabel>
                eapxml::get_element_localized(pXmlElProviderInfo, winstd::bstr(L"eap-metadata:UserNameLabel"), lang.c_str(), m_lbl_alt_identity);

                // <PasswordLabel>
                eapxml::get_element_localized(pXmlElProviderInfo, winstd::bstr(L"eap-metadata:PasswordLabel"), lang.c_str(), m_lbl_alt_password);
            }

            // Iterate authentication methods (<AuthenticationMethods>).
            m_methods.clear();
            winstd::com_obj<IXMLDOMNodeList> pXmlListMethods;
            if ((dwResult = eapxml::select_nodes(pConfigRoot, winstd::bstr(L"eap-metadata:AuthenticationMethods/eap-metadata:AuthenticationMethod"), &pXmlListMethods)) != ERROR_SUCCESS) {
                *ppEapError = m_module.make_error(dwResult = ERROR_NOT_FOUND, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error selecting <AuthenticationMethods>/<AuthenticationMethod> elements."), NULL);
                return dwResult;
            }
            long lCount = 0;
            pXmlListMethods->get_length(&lCount);
            for (long i = 0; i < lCount; i++) {
                winstd::com_obj<IXMLDOMNode> pXmlElMethod;
                pXmlListMethods->get_item(i, &pXmlElMethod);

                _Tmeth cfg(m_module);

                // Check EAP method type (<EAPMethod>).
                DWORD dwMethodID;
                if (eapxml::get_element_value(pXmlElMethod, winstd::bstr(L"eap-metadata:EAPMethod"), &dwMethodID) == ERROR_SUCCESS) {
                    if ((eap::type_t)dwMethodID != cfg.get_method_id()) {
                        // Wrong type.
                        continue;
                    }
                }

                // Load configuration.
                dwResult = cfg.load(pXmlElMethod, ppEapError);
                if (dwResult != ERROR_SUCCESS)
                    return dwResult;

                // Add configuration to the list.
                m_methods.push_back(std::move(cfg));
            }

            return ERROR_SUCCESS;
        }

    public:
        std::wstring m_id;                      ///< Profile ID
        winstd::tstring m_lbl_alt_credential;   ///< Alternative label for credential prompt
        winstd::tstring m_lbl_alt_identity;     ///< Alternative label for identity prompt
        winstd::tstring m_lbl_alt_password;     ///< Alternative label for password prompt
        std::list<_Tmeth> m_methods;            ///< Method configurations
    };


    ///
    /// Providers configuration
    ///
    template <class _Tprov>
    class config_providers : public config
    {
    public:
        config_providers(_In_ module &mod) : config(mod)
        {
        }

        config_providers(_In_ const config_providers &other) :
            m_providers(other.m_providers),
            config(other)
        {
        }

        config_providers(_Inout_ config_providers &&other) :
            m_providers(std::move(other.m_providers)),
            config(std::move(other))
        {
        }

        config_providers& operator=(_In_ const config_providers &other)
        {
            if (this != &other) {
                (config&)*this = other;
                m_providers = other.m_providers;
            }

            return *this;
        }

        config_providers& operator=(_Inout_ config_providers &&other)
        {
            if (this != &other) {
                (config&&)*this = std::move(other);
                m_providers     = std::move(other.m_providers);
            }

            return *this;
        }

        ///
        /// Saves providers configuration to XML
        ///
        virtual DWORD save(_In_ IXMLDOMDocument *pDoc, _Inout_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError) const
        {
            const winstd::bstr bstrNamespace(L"urn:ietf:params:xml:ns:yang:ietf-eap-metadata");
            DWORD dwResult;
            HRESULT hr;

            // Select <EAPIdentityProviderList> node.
            winstd::com_obj<IXMLDOMNode> pXmlElIdentityProviderList;
            if ((dwResult = eapxml::select_node(pConfigRoot, winstd::bstr(L"eap-metadata:EAPIdentityProviderList"), &pXmlElIdentityProviderList)) != ERROR_SUCCESS) {
                *ppEapError = m_module.make_error(dwResult = ERROR_NOT_FOUND, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error selecting <EAPIdentityProviderList>/<EAPIdentityProvider> element."), NULL);
                return dwResult;
            }

            for (std::list<_Tprov>::const_iterator provider = m_providers.cbegin(), provider_end = m_providers.cend(); provider != provider_end; ++provider) {
                // <EAPIdentityProvider>
                winstd::com_obj<IXMLDOMElement> pXmlElIdentityProvider;
                if ((dwResult = eapxml::create_element(pDoc, winstd::bstr(L"EAPIdentityProvider"), bstrNamespace, &pXmlElIdentityProvider))) {
                    *ppEapError = m_module.make_error(dwResult, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating <EAPIdentityProvider> element."), NULL);
                    return dwResult;
                }

                // <EAPIdentityProvider>/...
                if ((dwResult = provider->save(pDoc, pXmlElIdentityProvider, ppEapError)) != ERROR_SUCCESS)
                    return dwResult;

                if (FAILED(hr = pXmlElIdentityProviderList->appendChild(pXmlElIdentityProvider, NULL))) {
                    *ppEapError = m_module.make_error(dwResult = HRESULT_CODE(hr), 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error appending <EAPIdentityProvider> element."), NULL);
                    return dwResult;
                }
            }

            return dwResult;
        }


        ///
        /// Loads providers configuration from XML
        ///
        virtual DWORD load(_In_ IXMLDOMNode *pConfigRoot, _Out_ EAP_ERROR **ppEapError)
        {
            assert(pConfigRoot);
            assert(ppEapError);
            DWORD dwResult;

            // Iterate authentication providers (<EAPIdentityProvider>).
            winstd::com_obj<IXMLDOMNodeList> pXmlListProviders;
            if ((dwResult = eapxml::select_nodes(pConfigRoot, winstd::bstr(L"eap-metadata:EAPIdentityProviderList/eap-metadata:EAPIdentityProvider"), &pXmlListProviders)) != ERROR_SUCCESS) {
                *ppEapError = m_module.make_error(dwResult = ERROR_NOT_FOUND, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error selecting <EAPIdentityProviderList><EAPIdentityProvider> elements."), NULL);
                return dwResult;
            }
            long lCount = 0;
            pXmlListProviders->get_length(&lCount);
            for (long i = 0; i < lCount; i++) {
                winstd::com_obj<IXMLDOMNode> pXmlElProvider;
                pXmlListProviders->get_item(i, &pXmlElProvider);

                _Tprov prov(m_module);

                // Load provider.
                dwResult = prov.load(pXmlElProvider, ppEapError);
                if (dwResult != ERROR_SUCCESS)
                    return dwResult;

                // Add provider to the list.
                m_providers.push_back(std::move(prov));
            }

            return dwResult;
        }

    public:
        std::list<_Tprov> m_providers;  ///< Providers configurations
    };


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
    template <class _Tcfg>
    class peer_ui : public module
    {
    public:
        ///
        /// Constructor
        ///
        peer_ui() : module() {}


        ///
        /// Converts XML into the configuration BLOB.
        ///
        /// \sa [EapPeerConfigXml2Blob function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363602.aspx)
        ///
        inline DWORD config_xml_to_blob(
            _In_  DWORD            dwFlags,
            _In_  IXMLDOMDocument2 *pConfigDoc,
            _Out_ BYTE             **ppConfigOut,
            _Out_ DWORD            *pdwConfigOutSize,
            _Out_ EAP_ERROR        **ppEapError)
        {
            UNREFERENCED_PARAMETER(dwFlags);
            assert(ppEapError);
            DWORD dwResult = ERROR_SUCCESS;
            ETW_FN_DWORD(dwResult);

            // <Config>
            assert(pConfigDoc);
            pConfigDoc->setProperty(winstd::bstr(L"SelectionNamespaces"), winstd::variant(L"xmlns:eaphostconfig=\"http://www.microsoft.com/provisioning/EapHostConfig\""));
            winstd::com_obj<IXMLDOMElement> pXmlElConfig;
            if ((dwResult = eapxml::select_element(pConfigDoc, winstd::bstr(L"//eaphostconfig:Config"), &pXmlElConfig)) != ERROR_SUCCESS)
                return dwResult;

            // Load configuration.
            pConfigDoc->setProperty(winstd::bstr(L"SelectionNamespaces"), winstd::variant(L"xmlns:eap-metadata=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\""));
            eap::config_providers<eap::config_provider<_Tcfg> > cfg(*this);
            dwResult = cfg.load(pXmlElConfig, ppEapError);
            if (dwResult != ERROR_SUCCESS)
                return dwResult;

            // Allocate BLOB for configuration.
            assert(ppConfigOut);
            assert(pdwConfigOutSize);
            *pdwConfigOutSize = (DWORD)eapserial::get_pk_size(cfg);
            *ppConfigOut = alloc_memory(*pdwConfigOutSize);
            if (!*ppConfigOut) {
                *ppEapError = make_error(dwResult = ERROR_OUTOFMEMORY, 0, NULL, NULL, NULL, winstd::tstring_printf(_T(__FUNCTION__) _T(" Error allocating memory for configuration BLOB (%uB)."), *pdwConfigOutSize).c_str(), NULL);
                return dwResult;
            }

            // Pack BLOB to output.
            unsigned char *cursor = *ppConfigOut;
            eapserial::pack(cursor, cfg);
            assert(cursor - *ppConfigOut <= *pdwConfigOutSize);

            return dwResult;
        }


        ///
        /// Converts the configuration BLOB to XML.
        ///
        /// The configuration BLOB is returned in the ppConnectionDataOut parameter of the EapPeerInvokeConfigUI function.
        ///
        /// \sa [EapPeerConfigBlob2Xml function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363601.aspx)
        ///
        inline DWORD config_blob_to_xml(
            _In_                             DWORD            dwFlags,
            _In_count_(dwConfigInSize) const BYTE             *pConfigIn,
            _In_                             DWORD            dwConfigInSize,
            _Out_                            IXMLDOMDocument2 **ppConfigDoc,
            _Out_                            EAP_ERROR        **ppEapError)
        {
            UNREFERENCED_PARAMETER(dwFlags);
            assert(ppEapError);
            DWORD dwResult = ERROR_SUCCESS;
            ETW_FN_DWORD(dwResult);
            HRESULT hr;

            // Unpack configuration.
            eap::config_providers<eap::config_provider<_Tcfg> > cfg(*this);
            if (pConfigIn || !dwConfigInSize) {
                const unsigned char *cursor = pConfigIn;
                eapserial::unpack(cursor, cfg);
                assert(cursor - pConfigIn <= dwConfigInSize);
            }

            // Create configuration XML document.
            winstd::com_obj<IXMLDOMDocument2> pDoc;
            if (FAILED(hr = pDoc.create(CLSID_DOMDocument60, NULL, CLSCTX_INPROC_SERVER))) {
                *ppEapError = make_error(dwResult = HRESULT_CODE(hr), 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error creating XML document."), NULL);
                return dwResult;
            }

            pDoc->put_async(VARIANT_FALSE);

            // Load empty XML configuration.
            VARIANT_BOOL isSuccess = VARIANT_FALSE;
            if (FAILED((hr = pDoc->loadXML(L"<Config xmlns=\"http://www.microsoft.com/provisioning/EapHostConfig\"><EAPIdentityProviderList xmlns=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\"></EAPIdentityProviderList></Config>", &isSuccess))))
                return dwResult = HRESULT_CODE(hr);
            if (!isSuccess) {
                *ppEapError = make_error(dwResult = ERROR_XML_PARSE_ERROR, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Loading XML template failed."), NULL);
                return dwResult;
            }

            // Select <Config> node.
            winstd::com_obj<IXMLDOMNode> pXmlElConfig;
            pDoc->setProperty(winstd::bstr(L"SelectionNamespaces"), winstd::variant(L"xmlns:eaphostconfig=\"http://www.microsoft.com/provisioning/EapHostConfig\""));
            if ((dwResult = eapxml::select_node(pDoc, winstd::bstr(L"eaphostconfig:Config"), &pXmlElConfig)) != ERROR_SUCCESS) {
                *ppEapError = make_error(dwResult = ERROR_NOT_FOUND, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" Error selecting <Config> element."), NULL);
                return dwResult;
            }

            // Save all providers.
            pDoc->setProperty(winstd::bstr(L"SelectionNamespaces"), winstd::variant(L"xmlns:eap-metadata=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\""));
            if ((dwResult = cfg.save(pDoc, pXmlElConfig, ppEapError)) != ERROR_SUCCESS)
                return dwResult;

            *ppConfigDoc = pDoc.detach();
            return dwResult;
        }


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
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_method &val)
    {
        pack(cursor, val.m_allow_save        );
        pack(cursor, val.m_anonymous_identity);
    }


    ///
    /// Returns packed size of a method configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    inline size_t get_pk_size(const eap::config_method &val)
    {
        return
            get_pk_size(val.m_allow_save        ) +
            get_pk_size(val.m_anonymous_identity);
    }


    ///
    /// Unpacks a method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_method &val)
    {
        unpack(cursor, val.m_allow_save        );
        unpack(cursor, val.m_anonymous_identity);
    }


    ///
    /// Packs a password based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_pass &val)
    {
        pack(cursor, (const eap::config_method&)val);
        pack(cursor, val.m_identity         );
        pack(cursor, val.m_password         );
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
        return
            get_pk_size((const eap::config_method&)val) +
            get_pk_size(val.m_identity         ) +
            get_pk_size(val.m_password         );
    }


    ///
    /// Unpacks a password based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_pass &val)
    {
        unpack(cursor, (eap::config_method&)val);
        unpack(cursor, val.m_identity   );
        unpack(cursor, val.m_password   );
    }


    ///
    /// Packs a TLS based method configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_tls &val)
    {
        pack(cursor, (const eap::config_method&)val);
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
            get_pk_size((const eap::config_method&)val) +
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
        unpack(cursor, (eap::config_method&)val    );
        unpack(cursor, val.m_trusted_root_ca);
        unpack(cursor, val.m_server_names   );
    }


    ///
    /// Packs a provider configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    template <class _Tmeth>
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_provider<_Tmeth> &val)
    {
        pack(cursor, val.m_id                );
        pack(cursor, val.m_lbl_alt_credential);
        pack(cursor, val.m_lbl_alt_identity  );
        pack(cursor, val.m_lbl_alt_password  );
        pack(cursor, val.m_methods           );
    }


    ///
    /// Returns packed size of a provider configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    template <class _Tmeth>
    inline size_t get_pk_size(const eap::config_provider<_Tmeth> &val)
    {
        return
            get_pk_size(val.m_id                ) +
            get_pk_size(val.m_lbl_alt_credential) +
            get_pk_size(val.m_lbl_alt_identity  ) +
            get_pk_size(val.m_lbl_alt_password  ) +
            get_pk_size(val.m_methods           );
    }


    ///
    /// Unpacks a provider configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    template <class _Tmeth>
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_provider<_Tmeth> &val)
    {
        unpack(cursor, val.m_id                );
        unpack(cursor, val.m_lbl_alt_credential);
        unpack(cursor, val.m_lbl_alt_identity  );
        unpack(cursor, val.m_lbl_alt_password  );

        std::list<_Tmeth>::size_type count = *(const std::list<_Tmeth>::size_type*&)cursor;
        cursor += sizeof(std::list<_Tmeth>::size_type);
        val.m_methods.clear();
        for (std::list<_Tmeth>::size_type i = 0; i < count; i++) {
            _Tmeth el(val.m_module);
            unpack(cursor, el);
            val.m_methods.push_back(std::move(el));
        }
    }


    ///
    /// Packs a providers configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[in]    val     Configuration to pack
    ///
    template <class _Tprov>
    inline void pack(_Inout_ unsigned char *&cursor, _In_ const eap::config_providers<_Tprov> &val)
    {
        pack(cursor, val.m_providers);
    }


    ///
    /// Returns packed size of a providers configuration
    ///
    /// \param[in] val  Configuration to pack
    ///
    /// \returns Size of data when packed (in bytes)
    ///
    template <class _Tprov>
    inline size_t get_pk_size(const eap::config_providers<_Tprov> &val)
    {
        return get_pk_size(val.m_providers);
    }


    ///
    /// Unpacks a providers configuration
    ///
    /// \param[inout] cursor  Memory cursor
    /// \param[out]   val     Configuration to unpack to
    ///
    template <class _Tprov>
    inline void unpack(_Inout_ const unsigned char *&cursor, _Out_ eap::config_providers<_Tprov> &val)
    {
        std::list<_Tprov>::size_type count = *(const std::list<_Tprov>::size_type*&)cursor;
        cursor += sizeof(std::list<_Tprov>::size_type);
        val.m_providers.clear();
        for (std::list<_Tprov>::size_type i = 0; i < count; i++) {
            _Tprov el(val.m_module);
            unpack(cursor, el);
            val.m_providers.push_back(std::move(el));
        }
    }
}
