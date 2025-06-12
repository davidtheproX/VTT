/****************************************************************************
** Meta object code from reading C++ file 'PDFViewer.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/PDFViewer.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'PDFViewer.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN9PDFViewerE_t {};
} // unnamed namespace

template <> constexpr inline auto PDFViewer::qt_create_metaobjectdata<qt_meta_tag_ZN9PDFViewerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "PDFViewer",
        "filePathChanged",
        "",
        "pageCountChanged",
        "currentPageChanged",
        "zoomChanged",
        "isValidChanged",
        "titleChanged",
        "pdfLoaded",
        "success",
        "pdfClosed",
        "error",
        "message",
        "onDocumentStatusChanged",
        "loadPdf",
        "filePath",
        "closePdf",
        "nextPage",
        "previousPage",
        "zoomIn",
        "zoomOut",
        "resetZoom",
        "fitToWidth",
        "fitToPage",
        "getPageImageUrl",
        "page",
        "getPageSize",
        "pageCount",
        "currentPage",
        "zoom",
        "isValid",
        "title"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'filePathChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'pageCountChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'currentPageChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'zoomChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isValidChanged'
        QtMocHelpers::SignalData<void()>(6, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'titleChanged'
        QtMocHelpers::SignalData<void()>(7, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'pdfLoaded'
        QtMocHelpers::SignalData<void(bool)>(8, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Bool, 9 },
        }}),
        // Signal 'pdfClosed'
        QtMocHelpers::SignalData<void()>(10, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'error'
        QtMocHelpers::SignalData<void(const QString &)>(11, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 12 },
        }}),
        // Slot 'onDocumentStatusChanged'
        QtMocHelpers::SlotData<void()>(13, 2, QMC::AccessPrivate, QMetaType::Void),
        // Method 'loadPdf'
        QtMocHelpers::MethodData<bool(const QString &)>(14, 2, QMC::AccessPublic, QMetaType::Bool, {{
            { QMetaType::QString, 15 },
        }}),
        // Method 'closePdf'
        QtMocHelpers::MethodData<void()>(16, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'nextPage'
        QtMocHelpers::MethodData<void()>(17, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'previousPage'
        QtMocHelpers::MethodData<void()>(18, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'zoomIn'
        QtMocHelpers::MethodData<void()>(19, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'zoomOut'
        QtMocHelpers::MethodData<void()>(20, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'resetZoom'
        QtMocHelpers::MethodData<void()>(21, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'fitToWidth'
        QtMocHelpers::MethodData<void()>(22, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'fitToPage'
        QtMocHelpers::MethodData<void()>(23, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'getPageImageUrl'
        QtMocHelpers::MethodData<QUrl(int)>(24, 2, QMC::AccessPublic, QMetaType::QUrl, {{
            { QMetaType::Int, 25 },
        }}),
        // Method 'getPageSize'
        QtMocHelpers::MethodData<QSize(int)>(26, 2, QMC::AccessPublic, QMetaType::QSize, {{
            { QMetaType::Int, 25 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'filePath'
        QtMocHelpers::PropertyData<QString>(15, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 0),
        // property 'pageCount'
        QtMocHelpers::PropertyData<int>(27, QMetaType::Int, QMC::DefaultPropertyFlags, 1),
        // property 'currentPage'
        QtMocHelpers::PropertyData<int>(28, QMetaType::Int, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 2),
        // property 'zoom'
        QtMocHelpers::PropertyData<qreal>(29, QMetaType::QReal, QMC::DefaultPropertyFlags | QMC::Writable | QMC::StdCppSet, 3),
        // property 'isValid'
        QtMocHelpers::PropertyData<bool>(30, QMetaType::Bool, QMC::DefaultPropertyFlags, 4),
        // property 'title'
        QtMocHelpers::PropertyData<QString>(31, QMetaType::QString, QMC::DefaultPropertyFlags, 5),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<PDFViewer, qt_meta_tag_ZN9PDFViewerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject PDFViewer::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9PDFViewerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9PDFViewerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN9PDFViewerE_t>.metaTypes,
    nullptr
} };

void PDFViewer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<PDFViewer *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->filePathChanged(); break;
        case 1: _t->pageCountChanged(); break;
        case 2: _t->currentPageChanged(); break;
        case 3: _t->zoomChanged(); break;
        case 4: _t->isValidChanged(); break;
        case 5: _t->titleChanged(); break;
        case 6: _t->pdfLoaded((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 7: _t->pdfClosed(); break;
        case 8: _t->error((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 9: _t->onDocumentStatusChanged(); break;
        case 10: { bool _r = _t->loadPdf((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 11: _t->closePdf(); break;
        case 12: _t->nextPage(); break;
        case 13: _t->previousPage(); break;
        case 14: _t->zoomIn(); break;
        case 15: _t->zoomOut(); break;
        case 16: _t->resetZoom(); break;
        case 17: _t->fitToWidth(); break;
        case 18: _t->fitToPage(); break;
        case 19: { QUrl _r = _t->getPageImageUrl((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QUrl*>(_a[0]) = std::move(_r); }  break;
        case 20: { QSize _r = _t->getPageSize((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QSize*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::filePathChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::pageCountChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::currentPageChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::zoomChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::isValidChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::titleChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)(bool )>(_a, &PDFViewer::pdfLoaded, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)()>(_a, &PDFViewer::pdfClosed, 7))
            return;
        if (QtMocHelpers::indexOfMethod<void (PDFViewer::*)(const QString & )>(_a, &PDFViewer::error, 8))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->filePath(); break;
        case 1: *reinterpret_cast<int*>(_v) = _t->pageCount(); break;
        case 2: *reinterpret_cast<int*>(_v) = _t->currentPage(); break;
        case 3: *reinterpret_cast<qreal*>(_v) = _t->zoom(); break;
        case 4: *reinterpret_cast<bool*>(_v) = _t->isValid(); break;
        case 5: *reinterpret_cast<QString*>(_v) = _t->title(); break;
        default: break;
        }
    }
    if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setFilePath(*reinterpret_cast<QString*>(_v)); break;
        case 2: _t->setCurrentPage(*reinterpret_cast<int*>(_v)); break;
        case 3: _t->setZoom(*reinterpret_cast<qreal*>(_v)); break;
        default: break;
        }
    }
}

const QMetaObject *PDFViewer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PDFViewer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9PDFViewerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int PDFViewer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void PDFViewer::filePathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void PDFViewer::pageCountChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void PDFViewer::currentPageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void PDFViewer::zoomChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void PDFViewer::isValidChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void PDFViewer::titleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void PDFViewer::pdfLoaded(bool _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 6, nullptr, _t1);
}

// SIGNAL 7
void PDFViewer::pdfClosed()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void PDFViewer::error(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 8, nullptr, _t1);
}
QT_WARNING_POP
