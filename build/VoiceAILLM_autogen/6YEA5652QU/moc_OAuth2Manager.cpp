/****************************************************************************
** Meta object code from reading C++ file 'OAuth2Manager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/OAuth2Manager.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'OAuth2Manager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN13OAuth2ManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto OAuth2Manager::qt_create_metaobjectdata<qt_meta_tag_ZN13OAuth2ManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "OAuth2Manager",
        "QML.Element",
        "auto",
        "weChatAuthenticationChanged",
        "",
        "dingTalkAuthenticationChanged",
        "weChatUserInfoChanged",
        "dingTalkUserInfoChanged",
        "weChatQRCodeChanged",
        "dingTalkQRCodeChanged",
        "weChatLoadingChanged",
        "dingTalkLoadingChanged",
        "authenticationError",
        "Provider",
        "provider",
        "error",
        "authenticationSuccess",
        "setWeChatCredentials",
        "appId",
        "appSecret",
        "setDingTalkCredentials",
        "authenticateWeChat",
        "AuthMethod",
        "method",
        "authenticateDingTalk",
        "refreshWeChatQRCode",
        "refreshDingTalkQRCode",
        "checkQRCodeStatus",
        "startWeChatOAuth",
        "startDingTalkOAuth",
        "refreshUserInfo",
        "logoutWeChat",
        "logoutDingTalk",
        "logoutAll",
        "onWeChatQRCodeReceived",
        "QNetworkReply*",
        "reply",
        "onDingTalkQRCodeReceived",
        "onWeChatAuthResult",
        "onDingTalkAuthResult",
        "onWeChatUserInfoReceived",
        "onDingTalkUserInfoReceived",
        "checkQRCodeStatusTimer",
        "isWeChatAuthenticated",
        "isDingTalkAuthenticated",
        "weChatUserInfo",
        "dingTalkUserInfo",
        "weChatQRCode",
        "dingTalkQRCode",
        "isWeChatLoading",
        "isDingTalkLoading",
        "WeChat",
        "DingTalk",
        "QRCode",
        "OAuth2Flow"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'weChatAuthenticationChanged'
        QtMocHelpers::SignalData<void()>(3, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dingTalkAuthenticationChanged'
        QtMocHelpers::SignalData<void()>(5, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'weChatUserInfoChanged'
        QtMocHelpers::SignalData<void()>(6, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dingTalkUserInfoChanged'
        QtMocHelpers::SignalData<void()>(7, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'weChatQRCodeChanged'
        QtMocHelpers::SignalData<void()>(8, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dingTalkQRCodeChanged'
        QtMocHelpers::SignalData<void()>(9, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'weChatLoadingChanged'
        QtMocHelpers::SignalData<void()>(10, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'dingTalkLoadingChanged'
        QtMocHelpers::SignalData<void()>(11, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'authenticationError'
        QtMocHelpers::SignalData<void(Provider, const QString &)>(12, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 13, 14 }, { QMetaType::QString, 15 },
        }}),
        // Signal 'authenticationSuccess'
        QtMocHelpers::SignalData<void(Provider)>(16, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 13, 14 },
        }}),
        // Slot 'setWeChatCredentials'
        QtMocHelpers::SlotData<void(const QString &, const QString &)>(17, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 18 }, { QMetaType::QString, 19 },
        }}),
        // Slot 'setDingTalkCredentials'
        QtMocHelpers::SlotData<void(const QString &, const QString &)>(20, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 18 }, { QMetaType::QString, 19 },
        }}),
        // Slot 'authenticateWeChat'
        QtMocHelpers::SlotData<void(AuthMethod)>(21, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 22, 23 },
        }}),
        // Slot 'authenticateWeChat'
        QtMocHelpers::SlotData<void()>(21, 4, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void),
        // Slot 'authenticateDingTalk'
        QtMocHelpers::SlotData<void(AuthMethod)>(24, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 22, 23 },
        }}),
        // Slot 'authenticateDingTalk'
        QtMocHelpers::SlotData<void()>(24, 4, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void),
        // Slot 'refreshWeChatQRCode'
        QtMocHelpers::SlotData<void()>(25, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'refreshDingTalkQRCode'
        QtMocHelpers::SlotData<void()>(26, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'checkQRCodeStatus'
        QtMocHelpers::SlotData<void(Provider)>(27, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 13, 14 },
        }}),
        // Slot 'startWeChatOAuth'
        QtMocHelpers::SlotData<void()>(28, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'startDingTalkOAuth'
        QtMocHelpers::SlotData<void()>(29, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'refreshUserInfo'
        QtMocHelpers::SlotData<void(Provider)>(30, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 13, 14 },
        }}),
        // Slot 'logoutWeChat'
        QtMocHelpers::SlotData<void()>(31, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'logoutDingTalk'
        QtMocHelpers::SlotData<void()>(32, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'logoutAll'
        QtMocHelpers::SlotData<void()>(33, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'onWeChatQRCodeReceived'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(34, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'onDingTalkQRCodeReceived'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(37, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'onWeChatAuthResult'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(38, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'onDingTalkAuthResult'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(39, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'onWeChatUserInfoReceived'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(40, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'onDingTalkUserInfoReceived'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(41, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 35, 36 },
        }}),
        // Slot 'checkQRCodeStatusTimer'
        QtMocHelpers::SlotData<void()>(42, 4, QMC::AccessPrivate, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'isWeChatAuthenticated'
        QtMocHelpers::PropertyData<bool>(43, QMetaType::Bool, QMC::DefaultPropertyFlags, 0),
        // property 'isDingTalkAuthenticated'
        QtMocHelpers::PropertyData<bool>(44, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'weChatUserInfo'
        QtMocHelpers::PropertyData<QString>(45, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'dingTalkUserInfo'
        QtMocHelpers::PropertyData<QString>(46, QMetaType::QString, QMC::DefaultPropertyFlags, 3),
        // property 'weChatQRCode'
        QtMocHelpers::PropertyData<QString>(47, QMetaType::QString, QMC::DefaultPropertyFlags, 4),
        // property 'dingTalkQRCode'
        QtMocHelpers::PropertyData<QString>(48, QMetaType::QString, QMC::DefaultPropertyFlags, 5),
        // property 'isWeChatLoading'
        QtMocHelpers::PropertyData<bool>(49, QMetaType::Bool, QMC::DefaultPropertyFlags, 6),
        // property 'isDingTalkLoading'
        QtMocHelpers::PropertyData<bool>(50, QMetaType::Bool, QMC::DefaultPropertyFlags, 7),
    };
    QtMocHelpers::UintData qt_enums {
        // enum 'Provider'
        QtMocHelpers::EnumData<Provider>(13, 13, QMC::EnumIsScoped).add({
            {   51, Provider::WeChat },
            {   52, Provider::DingTalk },
        }),
        // enum 'AuthMethod'
        QtMocHelpers::EnumData<AuthMethod>(22, 22, QMC::EnumIsScoped).add({
            {   53, AuthMethod::QRCode },
            {   54, AuthMethod::OAuth2Flow },
        }),
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
    });
    return QtMocHelpers::metaObjectData<OAuth2Manager, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject OAuth2Manager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN13OAuth2ManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN13OAuth2ManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN13OAuth2ManagerE_t>.metaTypes,
    nullptr
} };

void OAuth2Manager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<OAuth2Manager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->weChatAuthenticationChanged(); break;
        case 1: _t->dingTalkAuthenticationChanged(); break;
        case 2: _t->weChatUserInfoChanged(); break;
        case 3: _t->dingTalkUserInfoChanged(); break;
        case 4: _t->weChatQRCodeChanged(); break;
        case 5: _t->dingTalkQRCodeChanged(); break;
        case 6: _t->weChatLoadingChanged(); break;
        case 7: _t->dingTalkLoadingChanged(); break;
        case 8: _t->authenticationError((*reinterpret_cast< std::add_pointer_t<Provider>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 9: _t->authenticationSuccess((*reinterpret_cast< std::add_pointer_t<Provider>>(_a[1]))); break;
        case 10: _t->setWeChatCredentials((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 11: _t->setDingTalkCredentials((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 12: _t->authenticateWeChat((*reinterpret_cast< std::add_pointer_t<AuthMethod>>(_a[1]))); break;
        case 13: _t->authenticateWeChat(); break;
        case 14: _t->authenticateDingTalk((*reinterpret_cast< std::add_pointer_t<AuthMethod>>(_a[1]))); break;
        case 15: _t->authenticateDingTalk(); break;
        case 16: _t->refreshWeChatQRCode(); break;
        case 17: _t->refreshDingTalkQRCode(); break;
        case 18: _t->checkQRCodeStatus((*reinterpret_cast< std::add_pointer_t<Provider>>(_a[1]))); break;
        case 19: _t->startWeChatOAuth(); break;
        case 20: _t->startDingTalkOAuth(); break;
        case 21: _t->refreshUserInfo((*reinterpret_cast< std::add_pointer_t<Provider>>(_a[1]))); break;
        case 22: _t->logoutWeChat(); break;
        case 23: _t->logoutDingTalk(); break;
        case 24: _t->logoutAll(); break;
        case 25: _t->onWeChatQRCodeReceived((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 26: _t->onDingTalkQRCodeReceived((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 27: _t->onWeChatAuthResult((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 28: _t->onDingTalkAuthResult((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 29: _t->onWeChatUserInfoReceived((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 30: _t->onDingTalkUserInfoReceived((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 31: _t->checkQRCodeStatusTimer(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 25:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 26:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 27:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 28:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 29:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 30:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::weChatAuthenticationChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::dingTalkAuthenticationChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::weChatUserInfoChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::dingTalkUserInfoChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::weChatQRCodeChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::dingTalkQRCodeChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::weChatLoadingChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)()>(_a, &OAuth2Manager::dingTalkLoadingChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)(Provider , const QString & )>(_a, &OAuth2Manager::authenticationError, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (OAuth2Manager::*)(Provider )>(_a, &OAuth2Manager::authenticationSuccess, 9))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->isWeChatAuthenticated(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isDingTalkAuthenticated(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->weChatUserInfo(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->dingTalkUserInfo(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->weChatQRCode(); break;
        case 5: *reinterpret_cast<QString*>(_v) = _t->dingTalkQRCode(); break;
        case 6: *reinterpret_cast<bool*>(_v) = _t->isWeChatLoading(); break;
        case 7: *reinterpret_cast<bool*>(_v) = _t->isDingTalkLoading(); break;
        default: break;
        }
    }
}

const QMetaObject *OAuth2Manager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *OAuth2Manager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN13OAuth2ManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int OAuth2Manager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 32)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 32;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 32)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 32;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void OAuth2Manager::weChatAuthenticationChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void OAuth2Manager::dingTalkAuthenticationChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void OAuth2Manager::weChatUserInfoChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void OAuth2Manager::dingTalkUserInfoChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void OAuth2Manager::weChatQRCodeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void OAuth2Manager::dingTalkQRCodeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void OAuth2Manager::weChatLoadingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void OAuth2Manager::dingTalkLoadingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void OAuth2Manager::authenticationError(Provider _t1, const QString & _t2)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1, _t2);
}

// SIGNAL 9
void OAuth2Manager::authenticationSuccess(Provider _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 9, nullptr, _t1);
}
QT_WARNING_POP
