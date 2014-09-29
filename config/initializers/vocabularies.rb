# Files under app/vocabularies do not follow Rails naming conventions,
# so the autoloader isn't any help. We require them manually here.
require Rails.root.join('app/vocabularies/etd')