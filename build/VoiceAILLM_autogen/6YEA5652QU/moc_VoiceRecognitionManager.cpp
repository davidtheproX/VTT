/****************************************************************************
** Meta object code from reading C++ file 'VoiceRecognitionManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/VoiceRecognitionManager.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'VoiceRecognitionManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN23VoiceRecognitionManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto VoiceRecognitionManager::qt_create_metaobjectdata<qt_meta_tag_ZN23VoiceRecognitionManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "VoiceRecognitionManager",
        "QML.Element",
        "auto",
        "listeningChanged",
        "",
        "recordingChanged",
        "recognizedTextChanged",
        "audioLevelChanged",
        "configurationChanged",
        "availableDevicesChanged",
        "currentDeviceChanged",
        "textRecognized",
        "text",
        "error",
        "errorMessage",
        "googleApiKeyChanged",
        "availableMicrophonesChanged",
        "currentMicrophoneChanged",
        "isTestingChanged",
        "startListening",
        "stopListening",
        "toggleListening",
        "refreshMicrophones",
        "startMicrophoneTest",
        "stopMicrophoneTest",
        "updateAudioLevel",
        "processAudioData",
        "onSpeechRecognitionFinished",
        "QNetworkReply*",
        "reply",
        "onNetworkError",
        "QNetworkReply::NetworkError",
        "isListening",
        "isRecording",
        "recognizedText",
        "audioLevel",
        "isConfigured",
        "availableDevices",
        "currentDevice",
        "googleApiKey",
        "availableMicrophones",
        "currentMicrophone",
        "isTesting"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'listeningChanged'
        QtMocHelpers::SignalData<void()>(3, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'recordingChanged'
        QtMocHelpers::SignalData<void()>(5, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'recognizedTextChanged'
        QtMocHelpers::SignalData<void()>(6, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'audioLevelChanged'
        QtMocHelpers::SignalData<void()>(7, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'configurationChanged'
        QtMocHelpers::SignalData<void()>(8, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'availableDevicesChanged'
        QtMocHelpers::SignalData<void()>(9, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentDeviceChanged'
        QtMocHelpers::SignalData<void()>(10, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'textRecognized'
        QtMocHelpers::SignalData<void(const QString &)>(11, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 12 },
        }}),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(13, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 14 },
        }}),
        // Signal 'googleApiKeyChanged'
        QtMocHelpers::SignalData<void()>(15, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'availableMicrophonesChanged'
        QtMocHelpers::SignalData<void()>(16, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentMicrophoneChanged'
        QtMocHelpers::SignalData<void()>(17, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isTestingChanged'
        QtMocHelpers::SignalData<void()>(18, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'startListening'
        QtMocHelpers::SlotData<void()>(19, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'stopListening'
        QtMocHelpers::SlotData<void()>(20, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'toggleListening'
        QtMocHelpers::SlotData<void()>(21, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'refreshMicrophones'
        QtMocHelpers::SlotData<void()>(22, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'startMicrophoneTest'
        QtMocHelpers::SlotData<void()>(23, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'stopMicrophoneTest'
        QtMocHelpers::SlotData<void()>(24, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'updateAudioLevel'
        QtMocHelpers::SlotData<void()>(25, 4, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'processAudioData'
        QtMocHelpers::SlotData<void()>(26, 4, QMC::AccessPrivate, QMetaType::Void),
        // Slot 'onSpeechRecognitionFinished'
        QtMocHelpers::SlotData<void(QNetworkReply *)>(27, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 28, 29 },
        }}),
        // Slot 'onNetworkError'
        QtMocHelpers::SlotData<void(QNetworkReply::NetworkError)>(30, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 31, 13 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'isListening'
        QtMocHelpers::PropertyData<bool>(32, QMetaType::Bool, QMC::DefaultPropertyFlags, 0),
        // property 'isRecording'
        QtMocHelpers::PropertyData<bool>(33, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'recognizedText'
        QtMocHelpers::PropertyData<QString>(34, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
        // property 'audioLevel'
        QtMocHelpers::PropertyData<qreal>(35, QMetaType::QReal, QMC::DefaultPropertyFlags, 3),
        // property 'isConfigured'
        QtMocHelpers::PropertyData<bool>(36, QMetaType::Bool, QMC::DefaultPropertyFlags, 4),
        // property 'availableDevices'
        QtMocHelpers::PropertyData<QStringList>(37, QMetaType::QStringList, QMC::DefaultPropertyFlags, 5),
        // property 'currentDevice'
        QtMocHelpers::PropertyData<QString>(38, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 6),
        // property 'googleApiKey'
        QtMocHelpers::PropertyData<QString>(39, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 9),
        // property 'availableMicrophones'
        QtMocHelpers::PropertyData<QStringList>(40, QMetaType::QStringList, QMC::DefaultPropertyFlags, 10),
        // property 'currentMicrophone'
        QtMocHelpers::PropertyData<QString>(41, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 11),
        // property 'isTesting'
        QtMocHelpers::PropertyData<bool>(42, QMetaType::Bool, QMC::DefaultPropertyFlags, 12),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
    });
    return QtMocHelpers::metaObjectData<VoiceRecognitionManager, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT const QMetaObject VoiceRecognitionManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN23VoiceRecognitionManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN23VoiceRecognitionManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN23VoiceRecognitionManagerE_t>.metaTypes,
    nullptr
} };

void VoiceRecognitionManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<VoiceRecognitionManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->listeningChanged(); break;
        case 1: _t->recordingChanged(); break;
        case 2: _t->recognizedTextChanged(); break;
        case 3: _t->audioLevelChanged(); break;
        case 4: _t->configurationChanged(); break;
        case 5: _t->availableDevicesChanged(); break;
        case 6: _t->currentDeviceChanged(); break;
        case 7: _t->textRecognized((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 9: _t->googleApiKeyChanged(); break;
        case 10: _t->availableMicrophonesChanged(); break;
        case 11: _t->currentMicrophoneChanged(); break;
        case 12: _t->isTestingChanged(); break;
        case 13: _t->startListening(); break;
        case 14: _t->stopListening(); break;
        case 15: _t->toggleListening(); break;
        case 16: _t->refreshMicrophones(); break;
        case 17: _t->startMicrophoneTest(); break;
        case 18: _t->stopMicrophoneTest(); break;
        case 19: _t->updateAudioLevel(); break;
        case 20: _t->processAudioData(); break;
        case 21: _t->onSpeechRecognitionFinished((*reinterpret_cast< std::add_pointer_t<QNetworkReply*>>(_a[1]))); break;
        case 22: _t->onNetworkError((*reinterpret_cast< std::add_pointer_t<QNetworkReply::NetworkError>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 21:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply* >(); break;
            }
            break;
        case 22:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QNetworkReply::NetworkError >(); break;
            }
            break;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::listeningChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::recordingChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::recognizedTextChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::audioLevelChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::configurationChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::availableDevicesChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::currentDeviceChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)(const QString & )>(_a, &VoiceRecognitionManager::textRecognized, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)(const QString & )>(_a, &VoiceRecognitionManager::error, 8))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::googleApiKeyChanged, 9))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::availableMicrophonesChanged, 10))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::currentMicrophoneChanged, 11))
            return;
        if (QtMocHelpers::indexOfMethod<void (VoiceRecognitionManager::*)()>(_a, &VoiceRecognitionManager::isTestingChanged, 12))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->isListening(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isRecording(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->recognizedText(); break;
        case 3: *reinterpret_cast<qreal*>(_v) = _t->audioLevel(); break;
        case 4: *reinterpret_cast<bool*>(_v) = _t->isConfigured(); break;
        case 5: *reinterpret_cast<QStringList*>(_v) = _t->availableDevices(); break;
        case 6: *reinterpret_cast<QString*>(_v) = _t->currentDevice(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->googleApiKey(); break;
        case 8: *reinterpret_cast<QStringList*>(_v) = _t->availableMicrophones(); break;
        case 9: *reinterpret_cast<QString*>(_v) = _t->currentMicrophone(); break;
        case 10: *reinterpret_cast<bool*>(_v) = _t->isTesting(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 6: _t->setCurrentDevice(*reinterpret_cast<QString*>(_v)); break;
        case 7: _t->setGoogleApiKey(*reinterpret_cast<QString*>(_v)); break;
        case 9: _t->setCurrentMicrophone(*reinterpret_cast<QString*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *VoiceRecognitionManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *VoiceRecognitionManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN23VoiceRecognitionManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int VoiceRecognitionManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 23)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 23;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 23)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 23;
    }
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void VoiceRecognitionManager::listeningChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void VoiceRecognitionManager::recordingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void VoiceRecognitionManager::recognizedTextChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void VoiceRecognitionManager::audioLevelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void VoiceRecognitionManager::configurationChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void VoiceRecognitionManager::availableDevicesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void VoiceRecognitionManager::currentDeviceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void VoiceRecognitionManager::textRecognized(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1);
}

// SIGNAL 8
void VoiceRecognitionManager::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1);
}

// SIGNAL 9
void VoiceRecognitionManager::googleApiKeyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void VoiceRecognitionManager::availableMicrophonesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void VoiceRecognitionManager::currentMicrophoneChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}

// SIGNAL 12
void VoiceRecognitionManager::isTestingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 12, nullptr);
}
namespace {
struct qt_meta_tag_ZN11AudioBufferE_t {};
} // unnamed namespace

template <> constexpr inline auto AudioBuffer::qt_create_metaobjectdata<qt_meta_tag_ZN11AudioBufferE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "AudioBuffer",
        "audioLevelUpdated",
        "",
        "level"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'audioLevelUpdated'
        QtMocHelpers::SignalData<void(float)>(1, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Float, 3 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<AudioBuffer, qt_meta_tag_ZN11AudioBufferE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject AudioBuffer::staticMetaObject = { {
    QMetaObject::SuperData::link<QIODevice::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11AudioBufferE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11AudioBufferE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN11AudioBufferE_t>.metaTypes,
    nullptr
} };

void AudioBuffer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<AudioBuffer *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->audioLevelUpdated((*reinterpret_cast< std::add_pointer_t<float>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (AudioBuffer::*)(float )>(_a, &AudioBuffer::audioLevelUpdated, 0))
            return;
    }
}

const QMetaObject *AudioBuffer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AudioBuffer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11AudioBufferE_t>.strings))
        return static_cast<void*>(this);
    return QIODevice::qt_metacast(_clname);
}

int AudioBuffer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QIODevice::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 1)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void AudioBuffer::audioLevelUpdated(float _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1);
}
QT_WARNING_POP
