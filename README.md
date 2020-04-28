# TinyLDAP
Fefe's tinyldap server as Docker Image, see https://www.fefe.de/tinyldap for details

## How to run
First, you need to create the binary database file. These examples are taken from the official `GETTING.STARTED` readme file that can be obtained by downloading the sources.

First, prepare some LDIF-data and create the database. You could also add indices etc. Please refer to the `GETTING.STARTED` readme.

```
nano exp.ldif
touch data
docker run -v exp.ldif:/opt/exp.ldif -v data:/opt/data paulritter/tinyldap /opt/parse
docker run -d -v data:/opt/data -p 389:389 paulritter/tinyldap
```
