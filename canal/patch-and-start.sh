#!/bin/bash
# 容器启动时把 canal 默认配置改成：
#   - 工作模式：kafka
#   - MySQL / Kafka 地址：指向 compose 内的服务名
# 然后交给官方 app.sh 启动 canal
set -e

CONF=/home/admin/canal-server/conf
INST=$CONF/example/instance.properties

# canal.properties：切换 Kafka 模式，并指向 compose 的 kafka 服务
sed -i 's/^canal.serverMode =.*/canal.serverMode = kafka/' "$CONF/canal.properties"
sed -i 's/^kafka.bootstrap.servers =.*/kafka.bootstrap.servers = kafka:9092/' "$CONF/canal.properties"

# instance.properties：指向 compose 的 mysql，只同步 review 库，统一发到 review topic
sed -i 's/^canal.instance.master.address=.*/canal.instance.master.address=mysql:3306/' "$INST"
sed -i 's/^canal.instance.dbUsername=.*/canal.instance.dbUsername=canal/' "$INST"
sed -i 's/^canal.instance.dbPassword=.*/canal.instance.dbPassword=canal/' "$INST"
sed -i 's|^canal.instance.filter.regex=.*|canal.instance.filter.regex=review\\\\..*|' "$INST"
sed -i 's/^canal.mq.topic=.*/canal.mq.topic=review/' "$INST"

echo "[canal] patched canal.properties:"
grep -E '^(canal.serverMode|kafka.bootstrap.servers)' "$CONF/canal.properties" || true
echo "[canal] patched instance.properties:"
grep -E '^(canal.instance.master.address|canal.instance.dbUsername|canal.mq.topic|canal.instance.filter.regex)' "$INST" || true

exec /home/admin/app.sh
