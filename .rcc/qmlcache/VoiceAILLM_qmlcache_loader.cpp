#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _0x5f_VoiceAILLM_qml_Main_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_ChatWindow_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_MessageDelegate_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_VoiceButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_SettingsDialog_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_PromptManagerDialog_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _0x5f_VoiceAILLM_qml_OAuth2LoginDialog_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/Main.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_Main_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/ChatWindow.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_ChatWindow_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/MessageDelegate.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_MessageDelegate_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/VoiceButton.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_VoiceButton_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/SettingsDialog.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_SettingsDialog_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/PromptManagerDialog.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_PromptManagerDialog_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/VoiceAILLM/qml/OAuth2LoginDialog.qml"), &QmlCacheGeneratedCode::_0x5f_VoiceAILLM_qml_OAuth2LoginDialog_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_VoiceAILLM)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_VoiceAILLM))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_VoiceAILLM)() {
    return 1;
}
