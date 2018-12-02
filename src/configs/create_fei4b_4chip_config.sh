#!/bin/sh

mod_id=$1
now=`date +"%y%m%d%H%M"`

# Change fixed tx channel and rx start channel
tx_fix=4
rx_start=4

for i in 1 2 3 4
do
    if [ -e ${mod_id}_fei4b_chipId$i.json ]; then
  cp ${mod_id}_fei4b_chipId$i.json backup/${mod_id}_fei4b_chipId$i.json.${now}
    fi
    cp default_fei4b.json ${mod_id}_fei4b_chipId$i.json
    sed -i "/chipId/s/0/$i/g" ${mod_id}_fei4b_chipId$i.json
    sed -i "/            \"rxChannel\": 99,/d" ${mod_id}_fei4b_chipId$i.json
    sed -i "/            \"txChannel\": 99,/d" ${mod_id}_fei4b_chipId$i.json
    j=`expr $i - 1 + $rx_start`
    sed -i "/rxChannel/s/0/$j/g" ${mod_id}_fei4b_chipId$i.json
    sed -i "/txChannel/s/0/$tx_fix/g" ${mod_id}_fei4b_chipId$i.json
    sed -i "/\"name\"/s/Example/${mod_id}_chipId$i/g" ${mod_id}_fei4b_chipId$i.json
done

sed "s/__MODULE_ID__/${mod_id}/g" connectivity/fei4module_default.json > connectivity/${mod_id}_fei4module.json

cd ../

# Register module and 4 chips component to DB
./bin/dbRegisterComponent configs/connectivity/${mod_id}_fei4module.json
