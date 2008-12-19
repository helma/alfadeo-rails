class AddContent < ActiveRecord::Migration

  def self.up

		Track.reset_column_information

		i = 1
		type = 'mix';
		for name in ['LautDeutlich_mix14','mix_04_12']

			mp3 = name+'.mp3'
			ogg = name+'.ogg'

			Track.create :displayed_name => name,
								 :position => i,
								 :track_type => type,
								 :mp3_name => mp3,
								 :ogg_name => ogg

			# add tracks to zip file
			trackDir = RAILS_ROOT + '/public/tracks/' 
			['mp3','ogg'].each do |format|
				zip_file = 'alfadeo-' + type.pluralize + '-' + format + '.zip'
				if format == 'mp3'
					`cd #{trackDir}; zip #{zip_file} #{mp3}`
				elsif format == 'ogg'
					`cd #{trackDir}; zip #{zip_file} #{ogg}`
				end
			end

			 i += 1

		end

		i = 1
		type = 'track';
		for name in ['06_03_01atrack1a', '060131_11_A01', '05_11_23ch3_d12', 'A+D140705_01d', 'A+D140705_02e', 'A+D140705_03h', '05_03_06_alexx', 'Abstraktol', 'Dubart', 'GoPell', 'Sonic5_119', '04_12_25_Stef_dirtymaster', '04_11_30_2', '04_11_24_4excerpt', '04_11_17v3']

			mp3 = name+'.mp3'
			ogg = name+'.ogg'

			Track.create :displayed_name => name,
								 :position => i,
								 :track_type => type,
								 :mp3_name => mp3,
								 :ogg_name => ogg

			# add tracks to zip file
			trackDir = RAILS_ROOT + '/public/tracks/' 
			['mp3','ogg'].each do |format|
				zip_file = 'alfadeo-' + type.pluralize + '-' + format + '.zip'
				if format == 'mp3'
					`cd #{trackDir}; zip #{zip_file} #{mp3}`
				elsif format == 'ogg'
					`cd #{trackDir}; zip #{zip_file} #{ogg}`
				end
			end

			 i += 1

		end
	end


  def self.down
		Track.delete_all
  end
end
