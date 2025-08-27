rm -f *.pem *.srl *.csr *.key ../webgateway/*.pem

openssl genrsa -out privatekey.pem 2048
openssl req -new -key privatekey.pem -out certrequest.csr
openssl x509 -req -days 3650 -in certrequest.csr -signkey privatekey.pem -out certificate.pem
openssl x509 -req -days 3650 -in certrequest.csr -CA certificate.pem -CAkey privatekey.pem -CAcreateserial -out sslcliauth.pem 

cp *.pem ../webgateway/.

# openssl pkcs12 -in yourpfxfile.pfx -out sslcliauth.pem -nodes
