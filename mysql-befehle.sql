
# Nun geht es um die SSL/TSL-Verschlüsselung:
# Dabei wird geprüft, ob SSL bereits aktiviert ist:

mysql> SHOW VARIABLES LIKE 'have_ssl';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| have_ssl      | YES   |
+---------------+-------+
1 row in set (0.02 sec)

# Im obigen Fall ist SSL bereits aktiviert.

# Firewall und Sicherheit einrichten

Nun werden Einstellungen vorgenommen, die dafür sorgen sollen, dass nur bestimmte Verbindungen erlaubt werden
und unnötige Ports blockiert werden:

In der Bash wird folgendes angegeben:

'sudo ufw status verbose'

Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
80,443/tcp (Nginx Full)    ALLOW IN    Anywhere
27017                      ALLOW IN    Anywhere
3306                       ALLOW IN    Anywhere
80,443/tcp (Nginx Full (v6)) ALLOW IN    Anywhere (v6)
27017 (v6)                 ALLOW IN    Anywhere (v6)
3306 (v6)                  ALLOW IN    Anywhere (v6)


Damit werden die Firewall-Regeln angezeigt. In diesem Fall ist die Firewall aktiv.

Nun geht es darum, nur sichere Verbindungen von localhost und einer bestimmten IP-Adresse zu erlauben.
Dazu wird folgender Befehl für MySQL verwendet:

'sudo ufw allow from 192.168.1.100 to any port 3306 proto tcp'
Dafür wird die entsprechende IP-Adresse verwendet.

Danach werden alle offenen Ports blockiert, die nicht gebraucht werden:

'sudo ufw deny 3306'


Danach wird der Status überprüft:

sudo ufw status numbered
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] Nginx Full                 ALLOW IN    Anywhere
[ 2] 27017                      ALLOW IN    Anywhere
[ 3] 3306                       DENY IN     Anywhere
[ 4] 3306/tcp                   ALLOW IN    172.24.207.255
[ 5] Nginx Full (v6)            ALLOW IN    Anywhere (v6)
[ 6] 27017 (v6)                 ALLOW IN    Anywhere (v6)
[ 7] 3306 (v6)                  DENY IN     Anywhere (v6)


Dieser Prozess dient dem Verständnis und zu Testzwecken.

# Prüfung der MySQL-Logs

'sudo cat /var/log/mysql/error.log | less'

Dieser Befehl wird zur Überprüfung der MySQL-Logs verwendet, um eventuelle Fehler
zu suchen, bspw. nach einem Neustart von MySQL. Die Einträge der Logdatei sehen beispielsweise so aus:

2025-02-13T17:14:04.643154Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.41-0ubuntu0.22.04.1) starting as process 711
2025-02-13T17:14:04.662696Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2025-02-13T17:14:05.245428Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2025-02-13T17:14:05.425417Z 0 [System] [MY-010229] [Server] Starting XA crash recovery...
2025-02-13T17:14:05.444059Z 0 [System] [MY-010232] [Server] XA crash recovery finished.
2025-02-13T17:14:05.504801Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2025-02-13T17:14:05.504865Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.


# Backup in MySQL erstellen: In dem Fall: Fußball-WM-Finals:

CREATE DATABASE wm_finals;

USE wm_finals;

CREATE TABLE finals (
    year INT PRIMARY KEY,
    host_country VARCHAR(50),
    winner VARCHAR(50),
    runner_up VARCHAR(50),
    score VARCHAR(10)
);

INSERT INTO finals (year, host_country, winner, runner_up, score) VALUES
(1930, 'Uruguay', 'Uruguay', 'Argentinien', '4-2'),
(1934, 'Italien', 'Italien', 'Tschechoslowakei', '2-1'),
(1938, 'Frankreich', 'Italien', 'Ungarn', '4-2'),
(1950, 'Brasilien', 'Uruguay', 'Brasilien', '2-1'),
(1954, 'Schweiz', 'Deutschland', 'Ungarn', '3-2'),
(1958, 'Schweden', 'Brasilien', 'Schweden', '5-2'),
(1962, 'Chile', 'Brasilien', 'Tschechoslowakei', '3-1'),
(1966, 'England', 'England', 'Deutschland', '4-2'),
(1970, 'Mexiko', 'Brasilien', 'Italien', '4-1'),
(1974, 'Deutschland', 'Deutschland', 'Niederlande', '2-1'),
(1978, 'Argentinien', 'Argentinien', 'Niederlande', '3-1'),
(1982, 'Spanien', 'Italien', 'Deutschland', '3-1'),
(1986, 'Mexiko', 'Argentinien', 'Deutschland', '3-2'),
(1990, 'Italien', 'Deutschland', 'Argentinien', '1-0'),
(1994, 'USA', 'Brasilien', 'Italien', '0-0 (3-2 i.E.)'),
(1998, 'Frankreich', 'Frankreich', 'Brasilien', '3-0'),
(2002, 'Japan/Südkorea', 'Brasilien', 'Deutschland', '2-0'),
(2006, 'Deutschland', 'Italien', 'Frankreich', '1-1 (5-3 i.E.)'),
(2010, 'Südafrika', 'Spanien', 'Niederlande', '1-0'),
(2014, 'Brasilien', 'Deutschland', 'Argentinien', '1-0'),
(2018, 'Russland', 'Frankreich', 'Kroatien', '4-2'),
(2022, 'Katar', 'Argentinien', 'Frankreich', '3-3 (4-2 i.E.)');


Anschließend folgen das Backup sowie die Prüfung, ob dieses erfolgreich war:

### mysqldump -u sik2 -p wm_finals > wm_finals_backup.sql
Enter password:
sik2@Sic2:~/mysql_server_project$ ls
mysql-befehle.sql  wm_finals_backup.sql
sik2@Sic2:~/mysql_server_project$ ls -lh
total 8.0K
-rw-r--r-- 1 sik2 sik2 2.2K Feb 12 21:58 mysql-befehle.sql
-rw-r--r-- 1 sik2 sik2 2.7K Feb 13 18:26 wm_finals_backup.sql

Das Backup kann dann mit folgendem Befehl wieder hergestellt werden:

mysql -u sik2 -p wm_finals < wm_finals_backup.sql

###


