/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#if __has_include(<ChatManager.h>)
#  include <ChatManager.h>
#endif
#if __has_include(<OAuth2Manager.h>)
#  include <OAuth2Manager.h>
#endif
#if __has_include(<TTSManager.h>)
#  include <TTSManager.h>
#endif
#if __has_include(<VoiceRecognitionManager.h>)
#  include <VoiceRecognitionManager.h>
#endif


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_VoiceAILLM()
{
    QT_WARNING_PUSH QT_WARNING_DISABLE_DEPRECATED
    qmlRegisterTypesAndRevisions<ChatManager>("VoiceAILLM", 1);
    qmlRegisterAnonymousType<QAbstractItemModel, 254>("VoiceAILLM", 1);
    qmlRegisterTypesAndRevisions<OAuth2Manager>("VoiceAILLM", 1);
    QMetaType::fromType<OAuth2Manager::Provider>().id();
    QMetaType::fromType<OAuth2Manager::AuthMethod>().id();
    qmlRegisterTypesAndRevisions<TTSManager>("VoiceAILLM", 1);
    qmlRegisterTypesAndRevisions<VoiceRecognitionManager>("VoiceAILLM", 1);
    QT_WARNING_POP
    qmlRegisterModule("VoiceAILLM", 1, 0);
}

static const QQmlModuleRegistration voiceAILLMRegistration("VoiceAILLM", qml_register_types_VoiceAILLM);
