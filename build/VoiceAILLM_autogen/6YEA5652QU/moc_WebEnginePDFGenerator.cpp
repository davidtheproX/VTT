/****************************************************************************
** Meta object code from reading C++ file 'WebEnginePDFGenerator.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/WebEnginePDFGenerator.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'WebEnginePDFGenerator.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN21WebEnginePDFGeneratorE_t {};
} // unnamed namespace

template <> constexpr inline auto WebEnginePDFGenerator::qt_create_metaobjectdata<qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "WebEnginePDFGenerator",
        "pdfGenerated",
        "",
        "filePath",
        "success",
        "error",
        "generationProgress",
        "percentage",
        "webEngineRenderCompleted",
        "renderedImage",
        "webEngineRenderFailed",
        "onWebEngineRenderCompleted",
        "QVariant",
        "imageData",
        "onWebEngineRenderFailed",
        "onWebEngineProgressChanged",
        "progress"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'pdfGenerated'
        QtMocHelpers::SignalData<void(const QString &, bool, const QString &)>(1, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 3 }, { QMetaType::Bool, 4 }, { QMetaType::QString, 5 },
        }}),
        // Signal 'generationProgress'
        QtMocHelpers::SignalData<void(int)>(6, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 7 },
        }}),
        // Signal 'webEngineRenderCompleted'
        QtMocHelpers::SignalData<void(const QImage &)>(8, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QImage, 9 },
        }}),
        // Signal 'webEngineRenderFailed'
        QtMocHelpers::SignalData<void(const QString &)>(10, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 5 },
        }}),
        // Slot 'onWebEngineRenderCompleted'
        QtMocHelpers::SlotData<void(const QVariant &)>(11, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { 0x80000000 | 12, 13 },
        }}),
        // Slot 'onWebEngineRenderFailed'
        QtMocHelpers::SlotData<void(const QString &)>(14, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 5 },
        }}),
        // Slot 'onWebEngineProgressChanged'
        QtMocHelpers::SlotData<void(qreal)>(15, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QReal, 16 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<WebEnginePDFGenerator, qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject WebEnginePDFGenerator::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>.metaTypes,
    nullptr
} };

void WebEnginePDFGenerator::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<WebEnginePDFGenerator *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->pdfGenerated((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 1: _t->generationProgress((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 2: _t->webEngineRenderCompleted((*reinterpret_cast< std::add_pointer_t<QImage>>(_a[1]))); break;
        case 3: _t->webEngineRenderFailed((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 4: _t->onWebEngineRenderCompleted((*reinterpret_cast< std::add_pointer_t<QVariant>>(_a[1]))); break;
        case 5: _t->onWebEngineRenderFailed((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 6: _t->onWebEngineProgressChanged((*reinterpret_cast< std::add_pointer_t<qreal>>(_a[1]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (WebEnginePDFGenerator::*)(const QString & , bool , const QString & )>(_a, &WebEnginePDFGenerator::pdfGenerated, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (WebEnginePDFGenerator::*)(int )>(_a, &WebEnginePDFGenerator::generationProgress, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (WebEnginePDFGenerator::*)(const QImage & )>(_a, &WebEnginePDFGenerator::webEngineRenderCompleted, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (WebEnginePDFGenerator::*)(const QString & )>(_a, &WebEnginePDFGenerator::webEngineRenderFailed, 3))
            return;
    }
}

const QMetaObject *WebEnginePDFGenerator::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *WebEnginePDFGenerator::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN21WebEnginePDFGeneratorE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int WebEnginePDFGenerator::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
    return _id;
}

// SIGNAL 0
void WebEnginePDFGenerator::pdfGenerated(const QString & _t1, bool _t2, const QString & _t3)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 0, nullptr, _t1, _t2, _t3);
}

// SIGNAL 1
void WebEnginePDFGenerator::generationProgress(int _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 1, nullptr, _t1);
}

// SIGNAL 2
void WebEnginePDFGenerator::webEngineRenderCompleted(const QImage & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 2, nullptr, _t1);
}

// SIGNAL 3
void WebEnginePDFGenerator::webEngineRenderFailed(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1);
}
QT_WARNING_POP
