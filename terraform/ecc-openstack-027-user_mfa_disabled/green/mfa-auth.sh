#!/bin/bash

OS_AUTH_URL=http://10.0.2.8/identity/v3
OS_USERNAME="027-user-green"
OS_USER_DOMAIN_NAME=Default
OS_PROJECT_DOMAIN_NAME=Default
OS_PROJECT_NAME=demo
OS_PASSWORD="password123"

echo "Please generate and enter a TOTP authentication code: "
read -r OS_TOTP_CODE

export OS_TOKEN=$(curl -v -s -X POST \
"$OS_AUTH_URL/auth/tokens?nocatalog" -H "Content-Type: application/json" \
-d '{
    "auth": {
        "identity": {
            "methods": ["password", "totp"],
            "password": {
                "user": {
                    "domain": {
                        "name": "'"$OS_USER_DOMAIN_NAME"'"
                    },
                    "name": "'"$OS_USERNAME"'",
                    "password": "'"$OS_PASSWORD"'"
                }
            },
            "totp": {
                "user": {
                    "domain": {
                        "name": "'"$OS_USER_DOMAIN_NAME"'"
                    },
                    "name": "'"$OS_USERNAME"'",
                    "passcode": "'"$OS_TOTP_CODE"'"
                }
            }
        },
        "scope": {
            "project": {
                "domain": {
                    "name": "'"$OS_PROJECT_DOMAIN_NAME"'"
                },
                "name": "'"$OS_PROJECT_NAME"'"
                }
            }
        }
    }' \
--stderr - | grep -i "X-Subject-Token" | cut -d':' -f2 | tr -d ' ' | tr -d '\r')

echo $OS_TOKEN