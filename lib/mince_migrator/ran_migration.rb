module MinceMigrator
  require 'mince/model'
  require 'mince/data_model'

  class RanMigrationDataModel
    include Mince::DataModel

    data_collection :migrations
    data_fields :name
  end

  class RanMigration
    include Mince::Model

    data_model RanMigrationDataModel
    field :name

    def self.find_by_name(name)
      data = data_model.find_by_field(:name, name)
      new data if data
    end

    def delete
      data_model.delete_by_params(name: name)
    end
  end
end
