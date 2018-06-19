#ifndef HANDLER_H
#define HANDLER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QGuiApplication>

class Handler : public QObject
{
    Q_OBJECT
public:
    explicit Handler(QObject *parent = nullptr);

    QList<QStringList> data;
    QFile file;

    void download();

signals:
    void rowAdd(QString msg1, QString msg2, QString msg3, QString msg4, QString msg5, QString msg6, QString msg7, QString msg8);
    void setUp();

public slots:
    void addChanges(QString msg, int x, int y);
};

#endif // HANDLER_H
