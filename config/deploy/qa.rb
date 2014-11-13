role :web,  "etda1qa.dlt.psu.edu"
role :app,  "etda1qa.dlt.psu.edu"
role :solr, "etda1qa.dlt.psu.edu" # This is where resolrize will run
role :db,   "etda1qa.dlt.psu.edu", primary: true # This is where Rails migrations will run
