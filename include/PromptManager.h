#ifndef PROMPTMANAGER_H
#define PROMPTMANAGER_H

#include <QObject>
#include <QAbstractListModel>
#include <QJsonObject>
#include <vector>
#include <memory>

class DatabaseManager;

struct Prompt {
    QString id;
    QString name;
    QString content;
    QString category;
    bool isActive;
    QDateTime createdAt;
    QDateTime modifiedAt;
};

class PromptManager : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int promptCount READ promptCount NOTIFY promptCountChanged)
    Q_PROPERTY(QString activePromptId READ activePromptId WRITE setActivePromptId NOTIFY activePromptIdChanged)

public:
    enum PromptRoles {
        IdRole = Qt::UserRole + 1,
        NameRole,
        ContentRole,
        CategoryRole,
        IsActiveRole,
        CreatedAtRole,
        ModifiedAtRole
    };

    explicit PromptManager(DatabaseManager *dbManager, QObject *parent = nullptr);
    ~PromptManager();

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    int promptCount() const { return static_cast<int>(m_prompts.size()); }
    QString activePromptId() const { return m_activePromptId; }
    void setActivePromptId(const QString &id);

    Q_INVOKABLE QString getActivePromptContent() const;
    Q_INVOKABLE QStringList getCategories() const;

public slots:
    void loadPrompts();
    void createPrompt(const QString &name, const QString &content, const QString &category);
    void updatePrompt(const QString &id, const QString &name, const QString &content, const QString &category);
    void deletePrompt(const QString &id);
    void activatePrompt(const QString &id);
    void importPrompts(const QString &filePath);
    void exportPrompts(const QString &filePath);

signals:
    void promptCountChanged();
    void activePromptIdChanged();
    void promptCreated(const QString &id);
    void promptUpdated(const QString &id);
    void promptDeleted(const QString &id);
    void error(const QString &errorMessage);

private:
    void refreshPrompts();
    Prompt jsonToPrompt(const QJsonObject &json) const;
    QJsonObject promptToJson(const Prompt &prompt) const;
    QString generatePromptId() const;

    std::vector<Prompt> m_prompts;
    DatabaseManager *m_dbManager;
    QString m_activePromptId;
};

#endif // PROMPTMANAGER_H 