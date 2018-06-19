#include "handler.h"

Handler::Handler(QObject *parent) : QObject(parent), file("content.csv")
{
}

void Handler::download()
{
    emit setUp();
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream stream(&file);
        forever
        {
            QString line = stream.readLine();
            if
                    (line.isNull())
                break;
            if
                    (line.isEmpty())
                continue;

            QStringList row;
            foreach(const QString& cell, line.split(";"))
            {
                row.append(cell.trimmed());
            }

            data.append(row);
            emit rowAdd(row.at(0), row.at(1), row.at(2), row.at(3), row.at(4), row.at(5), row.at(6), row.at(7));
        }
        file.close();
    }
//    else qDebug("WHAT?");
}

void Handler::addChanges(QString msg, int x, int y)
{
//    qDebug(data[x][y].toStdString().c_str());
//    qDebug(msg.toStdString().c_str());
    data[x][y] = msg;

    if (file.open(QIODevice::WriteOnly | QIODevice::Truncate | QIODevice::Text))
    {
        QTextStream out(&file);
        for( QStringList list_el: data)
            out << list_el.at(0) << ";" << list_el.at(1) << ";" << list_el.at(2) << ";"
                << list_el.at(3) << ";" << list_el.at(4) << ";" << list_el.at(5) << ";"
                << list_el.at(6) << ";" << list_el.at(7) << "\n";
        file.close();
    }
//    else qDebug("WHAAAAAAAAAAAT?");
}
