oc create --filename mattermost.yaml # to import the template
oc create serviceaccount mattermost # our deployment will use this
oc create secret generic mattermost-database --from-literal=user=mmuser --from-literal=password=mostest 
oc secrets link mattermost mattermost-database # make the secret available to the serviceaccount
oc new-app --template=openshift/postgresql-persistent --labels=app=mattermost --param=POSTGRESQL_USER=mmuser --param=POSTGRESQL_PASSWORD=mostest --param=POSTGRESQL_DATABASE=mattermost --param=VOLUME_CAPACITY=5G
oc new-app mattermost --labels=app=mattermost
oc new-build . --strategy=docker --name mattermost
oc expose service/mattermost --labels=app=mattermost --hostname=mattermost.192.168.42.2.nip.io
