docker run -d --name deemix \
           -v /opt/docker/deemix/config:/config \
           -v /opt/docker/deemix/music:/downloads \
           -p 33333:33333 \
           zerpex/deemix
