require 'mince_mongo_db'

Mince::Config.interface = MinceMongoDb::Interface
MinceMongoDb::Config.database_name = 'mince_migrator'
