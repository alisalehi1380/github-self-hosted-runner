#!/bin/bash
set -e

get_remove_token() {
  local repo="$1"
  local token="$2"

  echo "🔑 Requesting remove token from GitHub..." >&2

  local remove_token=$(
    curl -sSL \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer ${token}" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/${repo}/actions/runners/remove-token | jq -r .token
  )

  if [ "$remove_token" = "null" ]; then
    echo "❌ Failed to get remove token. Check your GITHUB_PERSONAL_TOKEN and repo/org name." >&2
    return 1
  fi

  echo "$remove_token"
}

get_registration_token() {
  local repo="$1"
  local token="$2"

  echo "🔑 Requesting registration token from GitHub..." >&2

  local registration_token=$(
    curl -sSL \
      -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer ${token}" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/${repo}/actions/runners/registration-token | jq -r .token
  )

  if [ "$registration_token" = "null" ] || [ -z "$registration_token" ]; then
    echo "❌ Failed to get registration token. Check your GITHUB_PERSONAL_TOKEN and repo/org name." >&2
    return 1
  fi

  echo "$registration_token"
}

WORKDIR="$RUNNER_HOME/actions-runner"
cd "$WORKDIR" || {
  echo "❌ Directory not found: $WORKDIR"
  exit 1
}

if [[ "$DISABLE_RUNNER_UPDATE" == "true" || "$DISABLE_RUNNER_UPDATE" == "1" ]]; then
  DISABLE_FLAG="--disableupdate"
  echo "🔒 Auto-update disabled"
else
  DISABLE_FLAG=""
  echo "⚙️ Auto-update enabled"
fi

if [ -f .runner ]; then
  echo "⚠️ Runner already configured, cleaning up old configuration..."
  remove_github_token=$(get_remove_token "${REPO}" "${GITHUB_PERSONAL_TOKEN}") || exit 1
  ./config.sh remove --token "${remove_github_token}"
fi

echo "⚙️ Configuring runner..."
registration_github_token=$(get_registration_token "${REPO}" "${GITHUB_PERSONAL_TOKEN}") || exit 1

./config.sh \
  --url https://github.com/${REPO} \
  --token ${registration_github_token} \
  --name ${RUNNER_NAME} \
  $DISABLE_FLAG

cleanup() {
  echo "🧹 Removing runner..."
  remove_github_token=$(get_remove_token "${REPO}" "${GITHUB_PERSONAL_TOKEN}") || exit 1
  ./config.sh remove --token "${remove_github_token}"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
