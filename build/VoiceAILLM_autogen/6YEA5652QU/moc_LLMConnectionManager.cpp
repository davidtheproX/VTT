/****************************************************************************
** Meta object code from reading C++ file 'LLMConnectionManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/LLMConnectionManager.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'LLMConnectionManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN20LLMConnectionManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto LLMConnectionManager::qt_create_metaobjectdata<qt_meta_tag_ZN20LLMConnectionManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "LLMConnectionManager",
        "responseReceived",
        "",
        "response",
        "streamingResponseUpdate",
        "partialResponse",
        "error",
        "errorMessage",
        "currentProviderChanged",
        "isConnectedChanged",
        "apiKeyChanged",
        "baseUrlChanged",
        "modelChanged",
        "requestStarted",
        "requestFinished",
        "sendMessage",
        "message",
        "systemPrompt",
        "testConnection",
        "cancelRequest",
        "handleNetworkReply",
        "handleTestConnectionReply",
        "currentProvider",
        "Provider",
        "isConnected",
        "apiKey",
        "baseUrl",
        "model",
        "OpenAI",
        "LMStudio",
        "Ollama"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'responseReceived'
        QtMocHelpers::SignalData<void(const QString &)>(1, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 3 },
        }}),
        // Signal 'streamingResponseUpdate'
        QtMocHelpers::SignalData<void(const QString &)>(4, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 5 },
        }}),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(6, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 7 },
        }}),
        // Signal 'currentProviderChanged'
        QtMocHelpers::SignalData<void()>(8, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isConnectedChanged'
        QtMocHelpers::SignalData<void()>(9, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'apiKeyChanged'
        QtMocHelpers::SignalData<void()>(10, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'baseUrlChanged'
        QtMocHelpers::SignalData<void()>(11, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'modelChanged'
        QtMocHelpers::SignalData<void()>(12, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'requestStarted'
        QtMocHelpers::SignalData<void()>(13, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'requestFinished'
        QtMocHelpers::SignalData<void()>(14, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'sendMessage'
        QtMocHelpers::SlotData<void(const QString &, const QString &)>(15, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 }, { QMetaType::QString, 17 },
        }}),
        // Slot 'sendMessage'
        QtMocHelpers::SlotData<void(const QString &)>(15, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Slot 'testConnection'
        QtMocHelpers::SlotData<void()>(18, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'cancelRequest'
        QtMocHelpers::SlotData<void()>(19, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'handleNetworkReply'
        QtMocHelpers::SlotData<void()>(20, 2, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'handleTestConnectionReply'
        QtMocHelpers::SlotData<void()>(21, 2, QMC::AccessPrivate, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'currentProvider'
        QtMocHelpers::PropertyData<Provider>(22, 0x80000000 | 23, QMC::DefaultPropertyFlags | QMC::Writable | QMC::EnumOrFlag | QMC::StdCppSet, 3),
        // property 'isConnected'
        QtMocHelpers::PropertyData<bool>(24, QMetaType::Bool, QMC::DefaultPropertyFlags, 4),
        // property 'apiKey'
        QtMocHelpers::PropertyData<QString>(25, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 5),
        // property 'baseUrl'
        QtMocHelpers::PropertyData<QString>(26, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 6),
        // property 'model'
        QtMocHelpers::PropertyData<QString>(27, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 7),
    };
    QtMocHelpers::UintData qt_enums {
        // enum 'Provider'
        QtMocHelpers::EnumData<Provider>(23, 23, QMC::EnumFlags{}).add({
            {   28, Provider::OpenAI },
            {   29, Provider::LMStudio },
            {   30, Provider::Ollama },
        }),
    };
    return QtMocHelpers::metaObjectData<LLMConnectionManager, qt_meta_tag_ZN20LLMConnectionManagerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject LLMConnectionManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN20LLMConnectionManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN20LLMConnectionManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN20LLMConnectionManagerE_t>.metaTypes,
    nullptr
} };

void LLMConnectionManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<LLMConnectionManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->responseReceived((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->streamingResponseUpdate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 2: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->currentProviderChanged(); break;
        case 4: _t->isConnectedChanged(); break;
        case 5: _t->apiKeyChanged(); break;
        case 6: _t->baseUrlChanged(); break;
        case 7: _t->modelChanged(); break;
        case 8: _t->requestStarted(); break;
        case 9: _t->requestFinished(); break;
        case 10: _t->sendMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 11: _t->sendMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 12: _t->testConnection(); break;
        case 13: _t->cancelRequest(); break;
        case 14: _t->handleNetworkReply(); break;
        case 15: _t->handleTestConnectionReply(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)(const QString & )>(_a, &LLMConnectionManager::responseReceived, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)(const QString & )>(_a, &LLMConnectionManager::streamingResponseUpdate, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)(const QString & )>(_a, &LLMConnectionManager::error, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::currentProviderChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::isConnectedChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::apiKeyChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::baseUrlChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::modelChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::requestStarted, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (LLMConnectionManager::*)()>(_a, &LLMConnectionManager::requestFinished, 9))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<Provider*>(_v) = _t->currentProvider(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isConnected(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->apiKey(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->baseUrl(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->model(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setCurrentProvider(*reinterpret_cast<Provider*>(_v)); break;
        case 2: _t->setApiKey(*reinterpret_cast<QString*>(_v)); break;
        case 3: _t->setBaseUrl(*reinterpret_cast<QString*>(_v)); break;
        case 4: _t->setModel(*reinterpret_cast<QString*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *LLMConnectionManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LLMConnectionManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN20LLMConnectionManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int LLMConnectionManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 16)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 16;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void LLMConnectionManager::responseReceived(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1);
}

// SIGNAL 1
void LLMConnectionManager::streamingResponseUpdate(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 1, nullptr, _t1);
}

// SIGNAL 2
void LLMConnectionManager::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 2, nullptr, _t1);
}

// SIGNAL 3
void LLMConnectionManager::currentProviderChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void LLMConnectionManager::isConnectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void LLMConnectionManager::apiKeyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void LLMConnectionManager::baseUrlChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void LLMConnectionManager::modelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void LLMConnectionManager::requestStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void LLMConnectionManager::requestFinished()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}
QT_WARNING_POP
