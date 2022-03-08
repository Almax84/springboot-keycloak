**GENERA KEYSTORE!**

keytool -genkeypair -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore key-cert-mousumi.p12 -validity 365

**PER IL TRUSTSTORE:**
ESPORTA CERTIFICATO GPSLAB DA CHROME

**CREA IL TRUSTSTORE**

keytool -importcert -keystore application.truststore -alias application -storepass password -file /home/davide/Scaricati/_.apps.lab01.gpslab.club -noprompt
Il certificato è stato aggiunto al keystore

**METTI IL CERTIFICATO IN SRC/MAIN/RESOURCES**

per vedere il truststore
keytool -list -v -keystore truststore.jks

**IMPORTA IL CERTIFICATO NEL KEYSTORE**

keytool -import -noprompt -trustcacerts -alias "initcert" -file /home/davide/Scaricati/_.apps.lab01.gpslab.club -keystore ./key-cert-mousumi.p12



**MODO CORRETTO: AGGIUNGI IL CERTIFICATO NEL CACERTS DELLA JVM**
sudo keytool -import -alias gpslab -keystore "/etc/java/java-11-openjdk/java-11-openjdk-11.0.14.1.1-4.fc35.x86_64/lib/security/cacerts" -file ~/Scaricati/_.apps.lab01.gpslab.club


per scaricare il certificato da linea di comando
openssl s_client  -connect keycloak-dscrimie.apps.lab01.gpslab.club:443  < /dev/null | openssl x509 -out prova.pem

queste due cose le deve fare il container...