class ConvertDatabase < ActiveRecord::Migration

  def self.up

    create_table "releases", :force => true do |t|
      t.string "name"
      t.string "description"
      t.string "image"
      t.date 'date'
      t.boolean 'publish', :default => false
      t.integer 'position'
    end

    oldmixes = Release.create(:name => "Old mixes", :description => "Archived alfadeo mixes", :publish => true)
    oldtracks = Release.create(:name => "Old tracks", :description => "Archived alfadeo tracks", :publish => true)

    rename_column("tracks", "displayed_name", "name")
    add_column("tracks", "file", "string")
    add_column("tracks", "release_id", "integer")

    Track.find(:all).each do |t|
      if t.hidden
        t.destroy
      else
        case t.track_type
        when "mix"
          t.release = oldmixes
        when "track"
          t.release = oldtracks
        end
        t.file = File.open("#{RAILS_ROOT}/public/tracks/#{t.mp3_name}")
        #t.file = t.mp3_name
        #FileUtil.cp("#{RAILS_ROOT}/public/tracks/#{t.mp3_name}", "#{RAILS_ROOT}/public/track/file/0000/#{t.id.to_s.rjust(4,'0')}/#{t.mp3_name}")
        t.save
      end
    end

    remove_column :tracks, :track_type
    remove_column :tracks, :hidden
    remove_column :tracks, :mp3_name
    remove_column :tracks, :ogg_name

  end

  def self.down
    drop_table "releases"
  end

end
