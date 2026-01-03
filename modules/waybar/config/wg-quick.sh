systemctl list-unit-files 'wg-quick-*.service' --no-legend | awk '{print $1}' | sed 's/wg-quick-\(.*\)\.service/\1/' | xargs -I {} sh -c 'echo "{}: $(systemctl is-active wg-quick-{})"'
