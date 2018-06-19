#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "handler.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject* root = engine.rootObjects()[0];
    Handler* handler = new Handler(root);

    engine.rootContext()->setContextProperty("handler", handler);

    handler->download();

    return app.exec();
}
