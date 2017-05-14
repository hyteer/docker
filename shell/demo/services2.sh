#!/bin/bash
services=(
		Base
		Qrcode
		Pay
		Product
		Shop 
		Message
		Users
		ThirdParty
		ThirdPartyInterface
)

function echo_srv () {
  for srv in ${services[@]}
  do
    echo "srv: ${srv}"
  done

}

echo_srv
