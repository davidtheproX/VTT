/****************************************************************************
** Meta object code from reading C++ file 'PDFManager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/PDFManager.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'PDFManager.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN10PDFManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto PDFManager::qt_create_metaobjectdata<qt_meta_tag_ZN10PDFManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "PDFManager",
        "isGeneratingChanged",
        "",
        "isViewerOpenChanged",
        "currentPdfPathChanged",
        "pdfGenerated",
        "filePath",
        "success",
        "pdfGenerationFailed",
        "error",
        "pdfOpened",
        "pdfClosed",
        "message",
        "onPdfGenerationFinished",
        "onPdfViewerClosed",
        "generatePdfFromJson",
        "jsonData",
        "outputPath",
        "generatePdfFromTemplate",
        "templatePath",
        "data",
        "generatePdfFromJsonWebEngine",
        "generatePdfFromTemplateWebEngine",
        "generatePdfFromJsonQML",
        "generatePdfFromTemplateQML",
        "templateName",
        "isWebEngineAvailable",
        "openPdfFile",
        "closePdfViewer",
        "loadTemplate",
        "fillTemplate",
        "templateContent",
        "isValidJson",
        "jsonString",
        "parseJsonString",
        "formatTableRows",
        "rows",
        "isGenerating",
        "isViewerOpen",
        "currentPdfPath"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'isGeneratingChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isViewerOpenChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentPdfPathChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'pdfGenerated'
        QtMocHelpers::SignalData<void(const QString &, bool)>(5, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 6 }, { QMetaType::Bool, 7 },
        }}),
        // Signal 'pdfGenerationFailed'
        QtMocHelpers::SignalData<void(const QString &)>(8, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 9 },
        }}),
        // Signal 'pdfOpened'
        QtMocHelpers::SignalData<void(const QString &)>(10, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 6 },
        }}),
        // Signal 'pdfClosed'
        QtMocHelpers::SignalData<void()>(11, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(9, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 12 },
        }}),
        // Slot 'onPdfGenerationFinished'
        QtMocHelpers::SlotData<void(const QString &, bool, const QString &)>(13, 2, QMC::AccessPrivate, QMetaType::Void, {{
            { QMetaType::QString, 6 }, { QMetaType::Bool, 7 }, { QMetaType::QString, 9 },
        }}),
        // Slot 'onPdfViewerClosed'
        QtMocHelpers::SlotData<void()>(14, 2, QMC::AccessPrivate, QMetaType::Void),
        // Method 'generatePdfFromJson'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(15, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromJson'
        QtMocHelpers::MethodData<void(const QString &)>(15, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Method 'generatePdfFromTemplate'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &, const QString &)>(18, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 19 }, { QMetaType::QJsonObject, 20 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromTemplate'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &)>(18, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 19 }, { QMetaType::QJsonObject, 20 },
        }}),
        // Method 'generatePdfFromJsonWebEngine'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(21, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromJsonWebEngine'
        QtMocHelpers::MethodData<void(const QString &)>(21, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Method 'generatePdfFromTemplateWebEngine'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &, const QString &)>(22, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 19 }, { QMetaType::QJsonObject, 20 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromTemplateWebEngine'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &)>(22, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 19 }, { QMetaType::QJsonObject, 20 },
        }}),
        // Method 'generatePdfFromJsonQML'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(23, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 16 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromJsonQML'
        QtMocHelpers::MethodData<void(const QString &)>(23, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 16 },
        }}),
        // Method 'generatePdfFromTemplateQML'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &, const QString &)>(24, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 25 }, { QMetaType::QJsonObject, 20 }, { QMetaType::QString, 17 },
        }}),
        // Method 'generatePdfFromTemplateQML'
        QtMocHelpers::MethodData<void(const QString &, const QJsonObject &)>(24, 2, QMC::AccessPublic | QMC::MethodCloned, QMetaType::Void, {{
            { QMetaType::QString, 25 }, { QMetaType::QJsonObject, 20 },
        }}),
        // Method 'isWebEngineAvailable'
        QtMocHelpers::MethodData<bool() const>(26, 2, QMC::AccessPublic, QMetaType::Bool),
        // Method 'openPdfFile'
        QtMocHelpers::MethodData<void()>(27, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'openPdfFile'
        QtMocHelpers::MethodData<void(const QString &)>(27, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 6 },
        }}),
        // Method 'closePdfViewer'
        QtMocHelpers::MethodData<void()>(28, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'loadTemplate'
        QtMocHelpers::MethodData<QString(const QString &)>(29, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::QString, 19 },
        }}),
        // Method 'fillTemplate'
        QtMocHelpers::MethodData<QString(const QString &, const QJsonObject &)>(30, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::QString, 31 }, { QMetaType::QJsonObject, 20 },
        }}),
        // Method 'isValidJson'
        QtMocHelpers::MethodData<bool(const QString &)>(32, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 33 },
        }}),
        // Method 'parseJsonString'
        QtMocHelpers::MethodData<QJsonObject(const QString &)>(34, 2, QMC::AccessPublic, QMetaType::QJsonObject, {{
            { QMetaType::QString, 33 },
        }}),
        // Method 'formatTableRows'
        QtMocHelpers::MethodData<QString(const QJsonArray &)>(35, 2, QMC::AccessPublic, QMetaType::QString, {{
            { QMetaType::QJsonArray, 36 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'isGenerating'
        QtMocHelpers::PropertyData<bool>(37, QMetaType::Bool, QMC::DefaultPropertyFlags, 0),
        // property 'isViewerOpen'
        QtMocHelpers::PropertyData<bool>(38, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'currentPdfPath'
        QtMocHelpers::PropertyData<QString>(39, QMetaType::QString, QMC::DefaultPropertyFlags, 2),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<PDFManager, qt_meta_tag_ZN10PDFManagerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject PDFManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10PDFManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10PDFManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN10PDFManagerE_t>.metaTypes,
    nullptr
} };

void PDFManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<PDFManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->isGeneratingChanged(); break;
        case 1: _t->isViewerOpenChanged(); break;
        case 2: _t->currentPdfPathChanged(); break;
        case 3: _t->pdfGenerated((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 4: _t->pdfGenerationFailed((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->pdfOpened((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 6: _t->pdfClosed(); break;
        case 7: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->onPdfGenerationFinished((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 9: _t->onPdfViewerClosed(); break;
        case 10: _t->generatePdfFromJson((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 11: _t->generatePdfFromJson((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 12: _t->generatePdfFromTemplate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 13: _t->generatePdfFromTemplate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 14: _t->generatePdfFromJsonWebEngine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 15: _t->generatePdfFromJsonWebEngine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 16: _t->generatePdfFromTemplateWebEngine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 17: _t->generatePdfFromTemplateWebEngine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 18: _t->generatePdfFromJsonQML((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 19: _t->generatePdfFromJsonQML((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 20: _t->generatePdfFromTemplateQML((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 21: _t->generatePdfFromTemplateQML((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 22: { bool _r = _t->isWebEngineAvailable();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 23: _t->openPdfFile(); break;
        case 24: _t->openPdfFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 25: _t->closePdfViewer(); break;
        case 26: { QString _r = _t->loadTemplate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 27: { QString _r = _t->fillTemplate((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 28: { bool _r = _t->isValidJson((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 29: { QJsonObject _r = _t->parseJsonString((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonObject*>(_a[0]) = std::move(_r); }  break;
        case 30: { QString _r = _t->formatTableRows((*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)()>(_a, &PDFManager::isGeneratingChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)()>(_a, &PDFManager::isViewerOpenChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)()>(_a, &PDFManager::currentPdfPathChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)(const QString & , bool )>(_a, &PDFManager::pdfGenerated, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)(const QString & )>(_a, &PDFManager::pdfGenerationFailed, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)(const QString & )>(_a, &PDFManager::pdfOpened, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)()>(_a, &PDFManager::pdfClosed, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFManager::*)(const QString & )>(_a, &PDFManager::error, 7))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<bool*>(_v) = _t->isGenerating(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isViewerOpen(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->currentPdfPath(); break;
        default: break;
        }
    }
}

const QMetaObject *PDFManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PDFManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN10PDFManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int PDFManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 31)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 31;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 31)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 31;
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
void PDFManager::isGeneratingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void PDFManager::isViewerOpenChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void PDFManager::currentPdfPathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void PDFManager::pdfGenerated(const QString & _t1, bool _t2)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 3, nullptr, _t1, _t2);
}

// SIGNAL 4
void PDFManager::pdfGenerationFailed(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 4, nullptr, _t1);
}

// SIGNAL 5
void PDFManager::pdfOpened(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 5, nullptr, _t1);
}

// SIGNAL 6
void PDFManager::pdfClosed()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void PDFManager::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1);
}
QT_WARNING_POP
