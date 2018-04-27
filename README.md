# Gather certificates

Run thomass/pound-certbot to gather certificates for your domains and
store them in a volume shared to pound:

```
docker run --rm -p 443:443 \
 -v etc_letsencrypt:/etc/letsencrypt \
 -e EMAIL=foobar@example.com \
 -e DOMAIN=example.com \
 -e DOMAINS=one.example.com,two.example.com,three.example.com,four.example.com \
 thomass/pound-certbot
```

# run pound

When starting pound it must instantaneous be connected to the network
all backends resides in, as it resolves the IP adresses on start. Pound
fails to start when at least one backend could not be resolved.

```
docker run -it --rm \
  -p 80:80 -p 443:443 \
  -v etc_letsencrypt:/etc/letsencrypt
  -e DOMAIN=example.com \
  -e tiller_json='{ "hosts": [ \
    { "subdomain": "one"},\
    { "subdomain": "two", "port": "8080"},\
    { "subdomain": "three", "internal_dns": "custom-backend"},\
    { "subdomain": "four", "internal_dns": "other-backend", "port": "3000"} ] }' \
  thomass/pound && \
docker network connect reverseproxy pound
```

* _one.example.com_ points to backend _https://one:80_
* _two.example.com_ points to backend _https://two:8080_
* _three.example.com_ points to backend _https://custom-backend:80_
* _four.example.com_ points to backend _https://other-backend:3000_
