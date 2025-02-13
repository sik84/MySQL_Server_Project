# MySQL Server Setup & Configuration

## Installation
Dieser Leitfaden beschreibt die Schritte zur Installation und sicheren Konfiguration eines MySQL-Servers unter Ubuntu 22.04 LTS.

### 1. MySQL-Server installieren
```bash
sudo apt update
sudo apt install mysql-server -y
```

### 2. MySQL-Installation absichern
```bash
sudo mysql_secure_installation
```
Folgende Sicherheitsmaßnahmen wurden getroffen:
- Passwortvalidierung: **Ja/Nein (je nach Wunsch)**
- Anonyme Benutzer entfernt: **Ja**
- Root-Login nur lokal erlaubt: **Ja**
- Test-Datenbank entfernt: **Ja**
- Berechtigungstabellen neu geladen: **Ja**

### 3. MySQL-Server starten, stoppen und Status prüfen
```bash
# MySQL-Server starten
sudo systemctl start mysql

# MySQL-Server stoppen
sudo systemctl stop mysql

# MySQL-Server-Status prüfen
sudo systemctl status mysql
```

## Benutzer & Rechteverwaltung
### Neuen MySQL-Benutzer erstellen
```sql
CREATE USER 'mein_user'@'%' IDENTIFIED BY 'mein_passwort';
```

### Berechtigungen setzen
```sql
GRANT ALL PRIVILEGES ON *.* TO 'mein_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

## Verbindung zur MySQL-Datenbank
### Anmeldung als Root (Socket-Authentifizierung)
```bash
sudo mysql
```

### Anmeldung als bestimmter Benutzer
```bash
mysql -u mein_user -p
```

## MySQL-Server für Remote-Zugriff konfigurieren (optional)
Falls der Zugriff aus dem Netzwerk erlaubt werden soll:

### 1. **Bind-Adresse in der Konfigurationsdatei anpassen**
```bash
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```
Ändere die Zeile:
```ini
bind-address = 0.0.0.0
```

### 2. **MySQL-Dienst neu starten**
```bash
sudo systemctl restart mysql
```

---

## Firewall- und Sicherheitskonfiguration

### **Firewall-Status prüfen**
```bash
sudo ufw status verbose
```

### **Nur Verbindungen von einer bestimmten IP erlauben**
```bash
sudo ufw allow from 192.168.1.100 to any port 3306 proto tcp
```

### **Alle anderen Zugriffe auf MySQL blockieren**
```bash
sudo ufw deny 3306
```

---

## MySQL-Logs prüfen
Falls Fehler oder Sicherheitsprobleme überprüft werden müssen, können die Logs eingesehen werden:

```bash
sudo cat /var/log/mysql/error.log | less
```

Falls es ältere Logs gibt, können diese mit `gzip` komprimiert sein:
```bash
zcat /var/log/mysql/error.log.1.gz
```

---

## Backup und Wiederherstellung

### **Backup erstellen**
```bash
mysqldump -u mein_user -p wm_finals > wm_finals_backup.sql
```

### **Backup wiederherstellen**
```bash
mysql -u mein_user -p wm_finals < wm_finals_backup.sql
```

---

## Datenbankbeispiel: Fußball-WM-Finals
Für Testzwecke wurde eine Datenbank mit den Ergebnissen aller Fußball-WM-Finals erstellt:

```sql
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
```

---

## Fazit & Nächste Schritte
Falls das Projekt weiter ausgebaut werden soll, könnten folgende Punkte umgesetzt werden:
- **Automatische Backups**: Einrichtung eines Cron-Jobs zur regelmäßigen Sicherung der Datenbank
- **Fehlertoleranz & Hochverfügbarkeit**: Replikation oder Clustering für produktive Umgebungen
- **Sicherheitsrichtlinien**: Zusätzliche Härtung des Systems, z. B. per Audit-Logging und restriktiveren Benutzerrechten

---


