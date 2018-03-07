module Calib::SoftDeletion::MigrationEnhancable
  def add_unique_column_for_soft_deletion(table, unique_column, filter_column = :alive)
    add_column_for_soft_deletion(table, filter_column)
    add_unique_index_for_soft_deletion(table, unique_column, filter_column)
  end

  def add_column_for_soft_deletion(table, filter_column = :alive)
    # @see https://qiita.com/yuba/items/70165875cfe02b03513d
    add_column table, filter_column, :integer, default: 1 # if canceled, alive=NULL for MYSQL
  end

  def add_unique_index_for_soft_deletion(table, unique_column, filter_column = :alive)
    if connection.adapter_name == 'MySQL'
      add_index table, [unique_column, filter_column], unique: true
    else
      # @see http://rny.io/rails/postgresql/2013/08/20/postgresql-indexing-in-rails.html
      add_index table, [unique_column, filter_column], unique: true, where: "#{filter_column} = 1" # for Postgresql indexes partial
    end
  end
end