/****************************************************************************
** Meta object code from reading C++ file 'ChatManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/ChatManager.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ChatManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN11ChatManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto ChatManager::qt_create_metaobjectdata<qt_meta_tag_ZN11ChatManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "ChatManager",
        "QML.Element",
        "auto",
        "isProcessingChanged",
        "",
        "messageCountChanged",
        "currentSystemPromptChanged",
        "messageAdded",
        "messageId",
        "messageUpdated",
        "error",
        "errorMessage",
        "processUserInput",
        "text",
        "clearChat",
        "regenerateLastResponse",
        "deleteMessage",
        "editMessage",
        "newContent",
        "exportChat",
        "filePath",
        "importChat",
        "writeTextFile",
        "content",
        "handleLLMResponse",
        "response",
        "handleStreamingUpdate",
        "partialResponse",
        "handleLLMError",
        "isProcessing",
        "messageCount",
        "currentSystemPrompt"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'isProcessingChanged'
        QtMocHelpers::SignalData<void()>(3, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'messageCountChanged'
        QtMocHelpers::SignalData<void()>(5, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentSystemPromptChanged'
        QtMocHelpers::SignalData<void()>(6, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'messageAdded'
        QtMocHelpers::SignalData<void(const QString &)>(7, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 },
        }}),
        // Signal 'messageUpdated'
        QtMocHelpers::SignalData<void(const QString &)>(9, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 },
        }}),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(10, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 11 },
        }}),
        // Slot 'processUserInput'
        QtMocHelpers::SlotData<void(const QString &)>(12, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 13 },
        }}),
        // Slot 'clearChat'
        QtMocHelpers::SlotData<void()>(14, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'regenerateLastResponse'
        QtMocHelpers::SlotData<void()>(15, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'deleteMessage'
        QtMocHelpers::SlotData<void(const QString &)>(16, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 },
        }}),
        // Slot 'editMessage'
        QtMocHelpers::SlotData<void(const QString &, const QString &)>(17, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 8 }, { QMetaType::QString, 18 },
        }}),
        // Slot 'exportChat'
        QtMocHelpers::SlotData<void(const QString &)>(19, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 20 },
        }}),
        // Slot 'importChat'
        QtMocHelpers::SlotData<void(const QString &)>(21, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 20 },
        }}),
        // Slot 'writeTextFile'
        QtMocHelpers::SlotData<bool(const QString &, const QString &)>(22, 4, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 20 }, { QMetaType::QString, 23 },
        }}),
        // Slot 'handleLLMResponse'
        QtMocHelpers::SlotData<void(const QString &)>(24, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 25 },
        }}),
        // Slot 'handleStreamingUpdate'
        QtMocHelpers::SlotData<void(const QString &)>(26, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 27 },
        }}),
        // Slot 'handleLLMError'
        QtMocHelpers::SlotData<void(const QString &)>(28, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 10 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'isProcessing'
        QtMocHelpers::PropertyData<bool>(29, QMetaType::Bool, QMC::DefaultPropertyFlags, 0),
        // property 'messageCount'
        QtMocHelpers::PropertyData<int>(30, QMetaType::Int, QMC::DefaultPropertyFlags, 1),
        // property 'currentSystemPrompt'
        QtMocHelpers::PropertyData<QString>(31, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 2),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
    });
    return QtMocHelpers::metaObjectData<ChatManager, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject ChatManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11ChatManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11ChatManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN11ChatManagerE_t>.metaTypes,
    nullptr
} };

void ChatManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<ChatManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->isProcessingChanged(); break;
        case 1: _t->messageCountChanged(); break;
        case 2: _t->currentSystemPromptChanged(); break;
        case 3: _t->messageAdded((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 4: _t->messageUpdated((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 6: _t->processUserInput((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 7: _t->clearChat(); break;
        case 8: _t->regenerateLastResponse(); break;
        case 9: _t->deleteMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 10: _t->editMessage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 11: _t->exportChat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 12: _t->importChat((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 13: { bool _r = _t->writeTextFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 14: _t->handleLLMResponse((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 15: _t->handleStreamingUpdate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 16: _t->handleLLMError((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)()>(_a, &ChatManager::isProcessingChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)()>(_a, &ChatManager::messageCountChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)()>(_a, &ChatManager::currentSystemPromptChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)(const QString & )>(_a, &ChatManager::messageAdded, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)(const QString & )>(_a, &ChatManager::messageUpdated, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (ChatManager::*)(const QString & )>(_a, &ChatManager::error, 5))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->isProcessing(); break;
        case 1: *reinterpret_cast<int*>(_v) = _t->messageCount(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->currentSystemPrompt(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 2: _t->setCurrentSystemPrompt(*reinterpret_cast<QString*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *ChatManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ChatManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11ChatManagerE_t>.strings))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int ChatManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 17)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 17)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 17;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void ChatManager::isProcessingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ChatManager::messageCountChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ChatManager::currentSystemPromptChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void ChatManager::messageAdded(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1);
}

// SIGNAL 4
void ChatManager::messageUpdated(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 4, nullptr, _t1);
}

// SIGNAL 5
void ChatManager::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 5, nullptr, _t1);
}
QT_WARNING_POP
