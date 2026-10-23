#!/usr/bin/env bash
set -euo pipefail

# Run from the repository root.
cd "$(dirname "$0")/.."

echo "=== Crombie Lab Website Preview ==="
echo
# Keep the URL local to this checkout and execution session, outside site output.
# --new-url replaces a saved URL if the OnDemand route changes mid-session.
case "${1:-}" in
    "") ;;
    --new-url) ;;
    *)
        echo "Usage: $0 [--new-url]" >&2
        exit 1
        ;;
esac
if (( $# > 1 )); then
    echo "Usage: $0 [--new-url]" >&2
    exit 1
fi

session_id="${SLURM_JOB_ID:-}"
if [[ -z "$session_id" ]]; then
    session_id="terminal-$(ps -o sid= -p "$$" | tr -d '[:space:]')"
fi
session_key="$(hostname):$session_id"
cache_file="$(git rev-parse --git-path crombie-preview-url)"
saved_session=""
saved_url=""
if [[ -r "$cache_file" ]]; then
    {
        IFS= read -r saved_session || true
        IFS= read -r saved_url || true
    } < "$cache_file"
fi

parse_url() {
    if [[ "$1" =~ ^https://ood\.fit\.edu(/rnode/[A-Za-z0-9._-]+/[0-9]+)(/[^[:space:]]*)?$ ]]; then
        baseurl="${BASH_REMATCH[1]}/proxy/4000"
        return 0
    fi
    return 1
}

if [[ "${1:-}" != "--new-url" && "$saved_session" == "$session_key" ]] && parse_url "$saved_url"; then
    echo "Reusing this session's OnDemand URL: $saved_url"
    echo "Run $0 --new-url to replace it."
else
    while true; do
        if ! read -r -p "Paste your current Open OnDemand URL: " input_url; then
            echo "ERROR: No OnDemand URL provided." >&2
            exit 1
        fi
        if parse_url "$input_url"; then
            break
        fi
        echo "ERROR: Expected https://ood.fit.edu/rnode/NODE/SESSION/..."
    done

    # Store only the route, never query parameters or authentication data.
    saved_url="https://ood.fit.edu${baseurl%/proxy/4000}/"
    if ! (umask 077; printf '%s\n%s\n' "$session_key" "$saved_url" > "$cache_file"); then
        echo "WARNING: Could not save the URL; continuing without caching." >&2
    fi
fi

# Create a temporary Jekyll configuration.
config=$(mktemp /tmp/crombie-preview.XXXXXX.yml)
trap 'rm -f "$config"' EXIT

cat > "$config" <<EOF
url: "https://ood.fit.edu"
baseurl: "$baseurl"
EOF

# Build the website.
echo
echo "Building Jekyll website..."

bundle exec jekyll build \
    --config "_config.yml,$config" \
    --quiet

# Pass the preview URL to Python.
export PREVIEW_BASEURL="$baseurl"

# Start a Python HTTP server with caching disabled.
python3 -u - <<'PY'
import os
import time
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer


class NoCacheHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store, no-cache, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        super().end_headers()


handler = partial(NoCacheHandler, directory="_site")

try:
    with ThreadingHTTPServer(("127.0.0.1", 4000), handler) as server:
        base = "https://ood.fit.edu" + os.environ["PREVIEW_BASEURL"]
        stamp = int(time.time())

        print()
        print("==========================================")
        print(" WEBSITE PREVIEW READY")
        print("==========================================")
        print()
        print("Research Projects:")
        print(f"{base}/projects/?preview={stamp}")
        print()
        print("Homepage / About:")
        print(f"{base}/?preview={stamp}")
        print()
        print("Open these links in a normal Chrome tab.")
        print("Browser caching is disabled for this server.")
        print("Keep this terminal open while previewing.")
        print("Press Ctrl+C to stop.")
        print("==========================================")
        print()

        try:
            server.serve_forever()
        except KeyboardInterrupt:
            print("\nPreview server stopped.")

except OSError as e:
    print(f"ERROR: Could not start server on port 4000: {e}")
    raise SystemExit(1)
PY
