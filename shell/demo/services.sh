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
for srv in ${services[@]}
do
echo "srv: ${srv}"
done

