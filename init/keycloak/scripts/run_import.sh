echo "Importing master.."
/opt/bitnami/keycloak/bin/kc.sh import --dir=/import --override true 2>/dev/null

### Resume normal execution
/opt/bitnami/scripts/keycloak/run.sh
