/****************************************************************************
** Meta object code from reading C++ file 'CSVViewer.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../include/CSVViewer.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'CSVViewer.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN9CSVViewerE_t {};
} // unnamed namespace

template <> constexpr inline auto CSVViewer::qt_create_metaobjectdata<qt_meta_tag_ZN9CSVViewerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "CSVViewer",
        "currentFileNameChanged",
        "",
        "isFileLoadedChanged",
        "totalRowsChanged",
        "totalColumnsChanged",
        "statusMessageChanged",
        "isLoadingChanged",
        "fileLoaded",
        "loadError",
        "message",
        "loadFile",
        "fileUrl",
        "resetChart",
        "toggleSeries",
        "seriesName",
        "visible",
        "setSeriesColor",
        "color",
        "filterData",
        "minTime",
        "maxTime",
        "clearFilter",
        "exportChart",
        "format",
        "exportData",
        "onChartHovered",
        "x",
        "y",
        "state",
        "onChartZoomed",
        "minX",
        "maxX",
        "minY",
        "maxY",
        "highlightDataPoint",
        "time",
        "savePreset",
        "name",
        "loadPreset",
        "getAvailablePresets",
        "getHeaders",
        "QVariantList",
        "getDataRow",
        "row",
        "getDataColumn",
        "column",
        "getDataValue",
        "QVariant",
        "getDataSummary",
        "QVariantMap",
        "currentFileName",
        "isFileLoaded",
        "totalRows",
        "totalColumns",
        "statusMessage",
        "isLoading"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'currentFileNameChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isFileLoadedChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'totalRowsChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'totalColumnsChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'statusMessageChanged'
        QtMocHelpers::SignalData<void()>(6, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'isLoadingChanged'
        QtMocHelpers::SignalData<void()>(7, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'fileLoaded'
        QtMocHelpers::SignalData<void()>(8, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'loadError'
        QtMocHelpers::SignalData<void(const QString &)>(9, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 10 },
        }}),
        // Slot 'loadFile'
        QtMocHelpers::SlotData<void(const QUrl &)>(11, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QUrl, 12 },
        }}),
        // Slot 'resetChart'
        QtMocHelpers::SlotData<void()>(13, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'toggleSeries'
        QtMocHelpers::SlotData<void(const QString &, bool)>(14, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 15 }, { QMetaType::Bool, 16 },
        }}),
        // Slot 'setSeriesColor'
        QtMocHelpers::SlotData<void(const QString &, const QColor &)>(17, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 15 }, { QMetaType::QColor, 18 },
        }}),
        // Slot 'filterData'
        QtMocHelpers::SlotData<void(qreal, qreal)>(19, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QReal, 20 }, { QMetaType::QReal, 21 },
        }}),
        // Slot 'clearFilter'
        QtMocHelpers::SlotData<void()>(22, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'exportChart'
        QtMocHelpers::SlotData<void(const QString &)>(23, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 24 },
        }}),
        // Slot 'exportData'
        QtMocHelpers::SlotData<void()>(25, 2, QMC::AccessPublic, QMetaType::Void),
        // Slot 'onChartHovered'
        QtMocHelpers::SlotData<void(const QString &, qreal, qreal, bool)>(26, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 15 }, { QMetaType::QReal, 27 }, { QMetaType::QReal, 28 }, { QMetaType::Bool, 29 },
        }}),
        // Slot 'onChartZoomed'
        QtMocHelpers::SlotData<void(qreal, qreal, qreal, qreal)>(30, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QReal, 31 }, { QMetaType::QReal, 32 }, { QMetaType::QReal, 33 }, { QMetaType::QReal, 34 },
        }}),
        // Slot 'highlightDataPoint'
        QtMocHelpers::SlotData<void(qreal)>(35, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QReal, 36 },
        }}),
        // Slot 'savePreset'
        QtMocHelpers::SlotData<void(const QString &)>(37, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 38 },
        }}),
        // Slot 'loadPreset'
        QtMocHelpers::SlotData<void(const QString &)>(39, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 38 },
        }}),
        // Slot 'getAvailablePresets'
        QtMocHelpers::SlotData<QStringList()>(40, 2, QMC::AccessPublic, QMetaType::QStringList),
        // Method 'getHeaders'
        QtMocHelpers::MethodData<QVariantList()>(41, 2, QMC::AccessPublic, 0x80000000 | 42),
        // Method 'getDataRow'
        QtMocHelpers::MethodData<QVariantList(int)>(43, 2, QMC::AccessPublic, 0x80000000 | 42, {{
            { QMetaType::Int, 44 },
        }}),
        // Method 'getDataColumn'
        QtMocHelpers::MethodData<QVariantList(int)>(45, 2, QMC::AccessPublic, 0x80000000 | 42, {{
            { QMetaType::Int, 46 },
        }}),
        // Method 'getDataValue'
        QtMocHelpers::MethodData<QVariant(int, int)>(47, 2, QMC::AccessPublic, 0x80000000 | 48, {{
            { QMetaType::Int, 44 }, { QMetaType::Int, 46 },
        }}),
        // Method 'getDataSummary'
        QtMocHelpers::MethodData<QVariantMap()>(49, 2, QMC::AccessPublic, 0x80000000 | 50),
    };
    QtMocHelpers::UintData qt_properties {
        // property 'currentFileName'
        QtMocHelpers::PropertyData<QString>(51, QMetaType::QString, QMC::DefaultPropertyFlags, 0),
        // property 'isFileLoaded'
        QtMocHelpers::PropertyData<bool>(52, QMetaType::Bool, QMC::DefaultPropertyFlags, 1),
        // property 'totalRows'
        QtMocHelpers::PropertyData<int>(53, QMetaType::Int, QMC::DefaultPropertyFlags, 2),
        // property 'totalColumns'
        QtMocHelpers::PropertyData<int>(54, QMetaType::Int, QMC::DefaultPropertyFlags, 3),
        // property 'statusMessage'
        QtMocHelpers::PropertyData<QString>(55, QMetaType::QString, QMC::DefaultPropertyFlags, 4),
        // property 'isLoading'
        QtMocHelpers::PropertyData<bool>(56, QMetaType::Bool, QMC::DefaultPropertyFlags, 5),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<CSVViewer, qt_meta_tag_ZN9CSVViewerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject CSVViewer::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9CSVViewerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9CSVViewerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN9CSVViewerE_t>.metaTypes,
    nullptr
} };

void CSVViewer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<CSVViewer *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->currentFileNameChanged(); break;
        case 1: _t->isFileLoadedChanged(); break;
        case 2: _t->totalRowsChanged(); break;
        case 3: _t->totalColumnsChanged(); break;
        case 4: _t->statusMessageChanged(); break;
        case 5: _t->isLoadingChanged(); break;
        case 6: _t->fileLoaded(); break;
        case 7: _t->loadError((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->loadFile((*reinterpret_cast< std::add_pointer_t<QUrl>>(_a[1]))); break;
        case 9: _t->resetChart(); break;
        case 10: _t->toggleSeries((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[2]))); break;
        case 11: _t->setSeriesColor((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QColor>>(_a[2]))); break;
        case 12: _t->filterData((*reinterpret_cast< std::add_pointer_t<qreal>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[2]))); break;
        case 13: _t->clearFilter(); break;
        case 14: _t->exportChart((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 15: _t->exportData(); break;
        case 16: _t->onChartHovered((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[4]))); break;
        case 17: _t->onChartZoomed((*reinterpret_cast< std::add_pointer_t<qreal>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<qreal>>(_a[4]))); break;
        case 18: _t->highlightDataPoint((*reinterpret_cast< std::add_pointer_t<qreal>>(_a[1]))); break;
        case 19: _t->savePreset((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 20: _t->loadPreset((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 21: { QStringList _r = _t->getAvailablePresets();
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = std::move(_r); }  break;
        case 22: { QVariantList _r = _t->getHeaders();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 23: { QVariantList _r = _t->getDataRow((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 24: { QVariantList _r = _t->getDataColumn((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 25: { QVariant _r = _t->getDataValue((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = std::move(_r); }  break;
        case 26: { QVariantMap _r = _t->getDataSummary();
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::currentFileNameChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::isFileLoadedChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::totalRowsChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::totalColumnsChanged, 3))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::statusMessageChanged, 4))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::isLoadingChanged, 5))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)()>(_a, &CSVViewer::fileLoaded, 6))
            return;
        if (QtMocHelpers::indexOfMethod<void (CSVViewer::*)(const QString & )>(_a, &CSVViewer::loadError, 7))
            return;
    }
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->currentFileName(); break;
        case 1: *reinterpret_cast<bool*>(_v) = _t->isFileLoaded(); break;
        case 2: *reinterpret_cast<int*>(_v) = _t->totalRows(); break;
        case 3: *reinterpret_cast<int*>(_v) = _t->totalColumns(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->statusMessage(); break;
        case 5: *reinterpret_cast<bool*>(_v) = _t->isLoading(); break;
        default: break;
        }
    }
}

const QMetaObject *CSVViewer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CSVViewer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN9CSVViewerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int CSVViewer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 27)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 27;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 27)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 27;
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
void CSVViewer::currentFileNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void CSVViewer::isFileLoadedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void CSVViewer::totalRowsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void CSVViewer::totalColumnsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void CSVViewer::statusMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void CSVViewer::isLoadingChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void CSVViewer::fileLoaded()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void CSVViewer::loadError(const QString & _t1)
{
    QMetaObject::activate<void>(this, &staticMetaObject, 7, nullptr, _t1);
}
QT_WARNING_POP
