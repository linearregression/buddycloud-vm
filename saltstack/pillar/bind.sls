bind:
  lookup:
    pkgs:
      - bind
    service:
      - named

bind:
  config:
    tmpl: salt://bind/files/debian/named.conf
    user: root
    group: named
    mode: 640
    options:
      allow-recursion: '{ any; };'  # Never include this on a public resolver

bind:
  keys:
    "core_dhcp":
      secret: "YourSecretKey"
  configured_zones:
    {{ salt['pillar.get']('buddycloud:lookup:domain') }}:
      type: master
      notify: False
    1.168.192.in-addr.arpa:
      type: master
      notify: False

bind:
  available_zones:
    {{ salt['pillar.get']('buddycloud:lookup:domain') }}:
      file: db.{{ salt['pillar.get']('buddycloud:lookup:domain') }}
      masters: "127.0.0.1;"
