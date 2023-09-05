#!/bin/bash

SECRETS=("hmac-token-secret" "oauth-token-secret")

#hmac-token-name="hmac-token-secret"

for secret in "${SECRETS[@]}"; do
  echo "Start creating the secret：$secret"

  if [ "$secret" = "hmac-token-secret" ]; then

  generate_hmac_token_command="openssl rand -hex 20 > hmac"
  $generate_hmac_token_command

  create_hmac_token_secret="kubectl create secret generic hmac-token --from-file=./hmac -n kosmos-prow"
  $create_hmac_token_secret

  else

  echo "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" > ./oauth
  create_oauth_token_secret="kubectl create secret generic oauth-token --from-file=./oauth -n  kosmos-prow"
  $create_oauth_token_secret
  fi

  if [ $? -eq 0 ]; then
    echo "Secret created successfully：$secret"
  else
    echo "Secret created successfully：$secret"
    exit 1
  fi

  echo "Single secret is created：$secret"
done

echo "All secrets created"

