/****************************************************************************
** Meta object code from reading C++ file 'TTSManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/TTSManager.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'TTSManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN10TTSManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto TTSManager::qt_create_metaobjectdata<qt_meta_tag_ZN10TTSManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "TTSManager",
        "QML.Element",
        "auto",
        "enabledChanged",
        "",
        "speakingChanged",
        "availableVoicesChanged",
        "currentVoiceChanged",
        "rateChanged",
        "pitchChanged",
        "volumeChanged",
        "stateChanged",
        "QTextToSpeech::State",
        "state",
        "error",
        "errorMessage",
        "speak",
        "text",
        "stop",
        "pause",
        "resume",
        "initialize",
        "refreshVoices",
        "onStateChanged",
        "onErrorOccurred",
        "QTextToSpeech::ErrorReason",
        "reason",
        "errorString",
        "applyJarvisVoicePreset",
        "applyNaturalVoicePreset",
        "applyRobotVoicePreset",
        "applyChineseVoicePreset",
        "isEnabled",
        "isSpeaking",
        "availableVoices",
        "currentVoice",
        "rate",
        "pitch",
        "volume"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'enabledChanged'
        QtMocHelpers::SignalData<void()>(3, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'speakingChanged'
        QtMocHelpers::SignalData<void()>(5, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'availableVoicesChanged'
        QtMocHelpers::SignalData<void()>(6, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentVoiceChanged'
        QtMocHelpers::SignalData<void()>(7, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'rateChanged'
        QtMocHelpers::SignalData<void()>(8, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'pitchChanged'
        QtMocHelpers::SignalData<void()>(9, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'volumeChanged'
        QtMocHelpers::SignalData<void()>(10, 4, QMC::AccessPublic, QMetaType::Void),
        // Signal 'stateChanged'
        QtMocHelpers::SignalData<void(QTextToSpeech::State)>(11, 4, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 12, 13 },
        }}),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(14, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 15 },
        }}),
        // Slot 'speak'
        QtMocHelpers::SlotData<void(const QString &)>(16, 4, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 17 },
        }}),
        // Slot 'stop'
        QtMocHelpers::SlotData<void()>(18, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'pause'
        QtMocHelpers::SlotData<void()>(19, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'resume'
        QtMocHelpers::SlotData<void()>(20, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'initialize'
        QtMocHelpers::SlotData<void()>(21, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'refreshVoices'
        QtMocHelpers::SlotData<void()>(22, 4, QMC::AccessPublic, QMetaType::Void),
        // Slot 'onStateChanged'
        QtMocHelpers::SlotData<void(QTextToSpeech::State)>(23, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 12, 13 },
        }}),
        // Slot 'onErrorOccurred'
        QtMocHelpers::SlotData<void(QTextToSpeech::ErrorReason, const QString &)>(24, 4, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 25, 26 }, { QMetaType::QString, 27 },
        }}),
        // Method 'applyJarvisVoicePreset'
        QtMocHelpers::MethodData<void()>(28, 4, QMC::AccessPublic, QMetaType::Void),
        // Method 'applyNaturalVoicePreset'
        QtMocHelpers::MethodData<void()>(29, 4, QMC::AccessPublic, QMetaType::Void),
        // Method 'applyRobotVoicePreset'
        QtMocHelpers::MethodData<void()>(30, 4, QMC::AccessPublic, QMetaType::Void),
        // Method 'applyChineseVoicePreset'
        QtMocHelpers::MethodData<void()>(31, 4, QMC::AccessPublic, QMetaType::Void),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'isEnabled'
        QtMocHelpers::PropertyData<bool>(32, QMetaType::Bool, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 0),
        // property 'isSpeaking'
        QtMocHelpers::PropertyData<bool>(33, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'availableVoices'
        QtMocHelpers::PropertyData<QStringList>(34, QMetaType::QStringList, QMC::DefaultPropertyFlags, 2),
        // property 'currentVoice'
        QtMocHelpers::PropertyData<QString>(35, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 3),
        // property 'rate'
        QtMocHelpers::PropertyData<qreal>(36, QMetaType::QReal, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 4),
        // property 'pitch'
        QtMocHelpers::PropertyData<qreal>(37, QMetaType::QReal, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 5),
        // property 'volume'
        QtMocHelpers::PropertyData<qreal>(38, QMetaType::QReal, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 6),
        // property 'state'
        QtMocHelpers::PropertyData<QTextToSpeech::State>(13, 0x80000000 | 12, QMC::DefaultPropertyFlags | QMC::EnumOrFlag, 7),
    };
    QtMocHelpers::UintData qt_enums {
    };
    QtMocHelpers::UintData qt_constructors {};
    QtMocHelpers::ClassInfos qt_classinfo({
            {    1,    2 },
    });
    return QtMocHelpers::metaObjectData<TTSManager, void>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums, qt_constructors, qt_classinfo);
}
Q_CONSTINIT static const QMetaObject::SuperData qt_meta_extradata_ZN10TTSManagerE[] = {
    QMetaObject::SuperData::link<QTextToSpeech::staticMetaObject>(),
    nullptr
};

Q_CONSTINIT const QMetaObject TTSManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10TTSManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10TTSManagerE_t>.data,
    qt_static_metacall,
    qt_meta_extradata_ZN10TTSManagerE,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN10TTSManagerE_t>.metaTypes,
    nullptr
} };

void TTSManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<TTSManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->enabledChanged(); break;
        case 1: _t->speakingChanged(); break;
        case 2: _t->availableVoicesChanged(); break;
        case 3: _t->currentVoiceChanged(); break;
        case 4: _t->rateChanged(); break;
        case 5: _t->pitchChanged(); break;
        case 6: _t->volumeChanged(); break;
        case 7: _t->stateChanged((*reinterpret_cast< std::add_pointer_t<QTextToSpeech::State>>(_a[1]))); break;
        case 8: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 9: _t->speak((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 10: _t->stop(); break;
        case 11: _t->pause(); break;
        case 12: _t->resume(); break;
        case 13: _t->initialize(); break;
        case 14: _t->refreshVoices(); break;
        case 15: _t->onStateChanged((*reinterpret_cast< std::add_pointer_t<QTextToSpeech::State>>(_a[1]))); break;
        case 16: _t->onErrorOccurred((*reinterpret_cast< std::add_pointer_t<QTextToSpeech::ErrorReason>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 17: _t->applyJarvisVoicePreset(); break;
        case 18: _t->applyNaturalVoicePreset(); break;
        case 19: _t->applyRobotVoicePreset(); break;
        case 20: _t->applyChineseVoicePreset(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::enabledChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::speakingChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::availableVoicesChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::currentVoiceChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::rateChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::pitchChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)()>(_a, &TTSManager::volumeChanged, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)(QTextToSpeech::State )>(_a, &TTSManager::stateChanged, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (TTSManager::*)(const QString & )>(_a, &TTSManager::error, 8))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->isEnabled(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isSpeaking(); break;
        case 2: *reinterpret_cast<QStringList*>(_v) = _t->availableVoices(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->currentVoice(); break;
        case 4: *reinterpret_cast<qreal*>(_v) = _t->rate(); break;
        case 5: *reinterpret_cast<qreal*>(_v) = _t->pitch(); break;
        case 6: *reinterpret_cast<qreal*>(_v) = _t->volume(); break;
        case 7: *reinterpret_cast<QTextToSpeech::State*>(_v) = _t->state(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setIsEnabled(*reinterpret_cast<bool*>(_v)); break;
        case 3: _t->setCurrentVoice(*reinterpret_cast<QString*>(_v)); break;
        case 4: _t->setRate(*reinterpret_cast<qreal*>(_v)); break;
        case 5: _t->setPitch(*reinterpret_cast<qreal*>(_v)); break;
        case 6: _t->setVolume(*reinterpret_cast<qreal*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *TTSManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TTSManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10TTSManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int TTSManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 21)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 21;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 21)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 21;
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
void TTSManager::enabledChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void TTSManager::speakingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void TTSManager::availableVoicesChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void TTSManager::currentVoiceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void TTSManager::rateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void TTSManager::pitchChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void TTSManager::volumeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void TTSManager::stateChanged(QTextToSpeech::State _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1);
}

// SIGNAL 8
void TTSManager::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1);
}
QT_WARNING_POP
