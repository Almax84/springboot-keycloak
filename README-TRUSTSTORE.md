**GENERA KEYSTORE!**

keytool -genkeypair -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore key-cert-mousumi.p12 -validity 365

**PER IL TRUSTSTORE:**
ESPORTA CERTIFICATO GPSLAB DA CHROME

**CREA IL TRUSTSTORE**

keytool -importcert -keystore application.truststore -alias application -storepass password -file /home/davide/Scaricati/_.apps.lab01.gpslab.club -noprompt
Il certificato è stato aggiunto al keystore

CONVERTI IL CERTIFICATO NEL FORMATO CORRETTO PER LA JVM
keytool -importkeystore -srckeystore cacerts -destkeystore cacerts.jks -deststoretype JKS


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


COSE DA FARE SUL CONTAINER SPRING-BOOT PER USARE IL TRUSTSTORE PERSONALE
1. ESPORTA IL CERTIFICATO DELLA DESTINAZIONE
openssl s_client  -connect keycloak-dscrimie.apps.lab01.gpslab.club:443  < /dev/null | openssl x509 -out /tmp/prova.pem
2. CREA IL TRUSTSTORE
keytool -importcert -keystore appTruststore -alias application -storepass password -file /tmp/prova.pem -noprompt
3. CONVERTI IL TRUSTSTORE NEL FORMATO CORRETTO
keytool -importkeystore -srckeystore appTruststore -destkeystore appTruststore.jks -deststoretype JKS
4. AGGIUNGI LE OPZIONI JVM PER IL TRUSTSTORE
-Djavax.net.ssl.trustStore=/app/appTruststore.jks -Djavax.net.ssl.trustStorePassword=password
