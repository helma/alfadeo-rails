class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.column :displayed_name, :string
			t.column :position, :int
			t.column :track_type, :string
			t.column :hidden, :string
			t.column :mp3_name, :string
			#t.column :mp3_data, :binary, :limit => 200.megabyte
			t.column :ogg_name, :string
			#t.column :ogg_data, :binary, :limit => 200.megabyte
    end
  end

  def self.down
    drop_table :tracks
  end
end
