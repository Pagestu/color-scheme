#!/usr/bin/env bash
set -u

file="$1"
thumbnail="$GITHUB_WORKSPACE/patch/website/webo.jpg"

esc() { printf '%s' "$1" | sed 's/[][_*()~`>#+=|{}.!\\-]/\\&/g'; }
esc_code() { printf '%s' "$1" | sed 's/[`\\]/\\&/g'; }

commit_msg="$(esc_code "${COMMIT_MESSAGE:0:600}")"

msg="*$(esc "$TITLE")*
Branch: $(esc "$BRANCH")
\\#ci\\_${GITHUB_RUN_NUMBER}
\`\`\`
${commit_msg}
\`\`\`
[Commit]($COMMIT_URL)
[Workflow run]($RUN_URL)"

args=(-F document=@"$file" -F chat_id="$CHAT_ID"
      -F parse_mode=MarkdownV2 -F caption="$msg")

if [ -f "$thumbnail" ]; then
  args+=(-F thumbnail=@"$thumbnail")
else
  echo "Thumbnail not found: $thumbnail (sending without it)"
fi

response=$(curl -s "${args[@]}" \
  "https://api.telegram.org/bot$BOT_TOKEN/sendDocument")

echo "$response"
echo "$response" | grep -q '"ok":true' || { echo "Telegram upload failed"; exit 1; }