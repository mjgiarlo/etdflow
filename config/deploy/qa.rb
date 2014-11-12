# We use the ipv4 address for etda1qa.dlt.psu.edu to avoid an ipv6 connection,
# which is currently getting blocked due to firewall rules.
role :web,  "128.118.88.145"
role :app,  "128.118.88.145"
role :solr, "128.118.88.145" # This is where resolrize will run
role :db,   "128.118.88.145", primary: true # This is where Rails migrations will run
