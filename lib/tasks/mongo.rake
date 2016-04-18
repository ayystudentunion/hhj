namespace :mongo do
  MODELS_DIR = "#{Rails.root}/app/models"
  SEEDS_DIR = "#{Rails.root}/db/seeds/" + Rails.env

  namespace :model do
    task :export, [:model, :filename] => :environment do |_t, args|
      model = args[:model].constantize
      filename = args[:filename]
      objects = model.all
      puts "Saving objects for #{model} to #{filename}"
      File.open(filename, 'w') do |f|
        objects.each do |object|
          f.write(object.to_json)
          f.write("\r\n")
        end
      end unless objects.nil?
    end

    task :import, [:model, :filename] => :environment do |_t, args|
      model = args[:model].constantize
      # skip callback
      model.after_create.clear
      model.after_update.clear

      model.destroy_all
      filename = args[:filename]
      # FIXME: depentdent objects also get deleted
      File.foreach(filename) do |line|
        next if line.blank?
        object = model.new.from_json line.strip
        # skip validations since models aren't loaded in a proper order
        object.save! validate: false
      end
    end
  end

  def collections
    documents = []
    Dir.entries(MODELS_DIR).reject { |f| File.directory? f }.sort.each do |file|
      model_name = file.split('/').last.chomp('.rb')
      documents << { model: model_name.camelize, table: model_name }
    end
    puts 'Found models:'
    puts documents
    documents
  end

  task export: :environment do
    collections.each do |collection|
      table = collection[:table]
      model = collection[:model]
      dir = SEEDS_DIR
      filename = dir + '/' + table + '.json'
      Dir.mkdir dir unless Dir.exist? dir
      Rake::Task['mongo:model:export'].execute(model: model, filename: filename)
    end
  end

  task import: :environment do
    collections.each do |collection|
      table = collection[:table]
      model = collection[:model]
      dir = SEEDS_DIR
      filename = dir + '/' + table + '.json'
      Rake::Task['mongo:model:import'].execute(model: model, filename: filename)
    end
  end
end
