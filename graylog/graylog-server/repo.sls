graylog-server-gdebi:
  pkg.installed:
    - name: gdebi
    - onlyif:
      - apt-cache show graylog-server | grep "Version:" | awk -F ":" '$2 ~ /^ 1\.3.*$/ { exit 1 }'

graylog-server-deb-file:
  file.managed:
    - name: /tmp/graylog-1.3-repository-ubuntu14.04_latest.deb
    - source: salt://graylog/files/graylog-1.3-repository-ubuntu14.04_latest.deb
    - require:
      - pkg: graylog-server-gdebi
    - onlyif:
      - apt-cache show graylog-server | grep "Version:" | awk -F ":" '$2 ~ /^ 1\.3.*$/ { exit 1 }'

graylog-server-cmd-gdebi:
  cmd.run:
    - name: gdebi -n /tmp/graylog-1.3-repository-ubuntu14.04_latest.deb
    - require:
      - pkg: graylog-server-gdebi
    - onlyif:
      - apt-cache show graylog-server | grep "Version:" | awk -F ":" '$2 ~ /^ 1\.3.*$/ { exit 1 }'

graylog-server-apt-update:
  cmd.run:
    - name: apt-get update
    - onlyif:
      - apt-cache show graylog-server | grep "Version:" | awk -F ":" '$2 ~ /^ 1\.3.*$/ { exit 1 }'

