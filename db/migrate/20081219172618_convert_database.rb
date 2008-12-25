class ConvertDatabase < ActiveRecord::Migration

  def self.up

    create_table "releases", :force => true do |t|
      t.string "name", "description", "image", "zip"
      t.date 'date', :default => Date.today
      t.boolean 'publish', :default => false
      t.integer 'position', 'nr'
    end

    internal = Release.create(:name => "Internal", :description => "Unpublished alfadeo tracks", :publish => false, :position => 1, :date => Date.today )
    oldtracks = Release.create(:name => "Old tracks", :description => "Archived alfadeo tracks", :publish => true, :position => 2, :nr => 2, :date => Date.today )
    oldmixes = Release.create(:name => "Old mixes", :description => "Archived alfadeo mixes", :publish => true, :position => 3,  :nr => 1,:date => Date.today )

    rename_column("tracks", "displayed_name", "name")
    rename_column :tracks, :hidden, :internal
    add_column("tracks", "file", "string")
    add_column("tracks", "release_id", "integer")
    add_column :tracks, :length, :float

    Track.find(:all).each do |t|
      if t.internal
        t.release = internal
      else
        case t.track_type
        when "mix"
          t.release = oldmixes unless t.internal
        when "track"
          t.release = oldtracks unless t.internal
        end
      end
      t.file = File.open("#{RAILS_ROOT}/public/tracks/#{t.mp3_name}")
      Mp3Info.open(t.file) do |mp3|
        t.length = mp3.length
      end
      t.save
    end

    remove_column :tracks, :track_type
    remove_column :tracks, :mp3_name
    remove_column :tracks, :ogg_name

    Release.find(:all).each do |r|
      r.save
    end

  end

  def self.down
    drop_table "releases"
  end

end
