#!/bin/bash
#this script will run tdx in screen
#source tdx_params.sh
TDX_PATH=`which tdxminer`
TDX_PARAMS="-a lyra2z -o stratum+tcp://us-central01.miningrigrentals.com:51669 -u $USER"
screen -dmS tdx sh -c  'bash tdxminer $TDX_PARAMS'
