role :web,  "etda1stage.dlt.psu.edu"
role :app,  "etda1stage.dlt.psu.edu"
role :solr, "etda1stage.dlt.psu.edu" # This is where resolrize will run
role :db,   "etda1stage.dlt.psu.edu", primary: true # This is where Rails migrations will run
