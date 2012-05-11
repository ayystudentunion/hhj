namespace :db do
  namespace :import do

    desc "import university organization chart from YAML file"
    task :university => :environment do
      file = ENV['file']
      raise "file parameter missing!\n\n" +
      "Usage:\n" +
      "RAILS_ENV=[env name] rake db:import:university file=[path to yaml file]\n\n" +
      "e.g. 'RAILS_ENV=production rake db:import:university ./resources/helsinki.yaml'\n\n" +
      "The name of the yaml file will be the identifier of the university. " +
      "E.g. helsinki.yaml will result organization found under www.halloped.fi/fi/helsinki\n" +
      "The identifier will also be used when mapping haka credentials so it must be \n" +
      "(the yaml file name must be) the same as first part of university domain name.\n\n" +
      "RAILS_ENV is development by default. If you want to import university to production server\n" +
      "you must use RAILS_ENV=production\n\n" +
      "Tips: look under resources/ for example files" unless file

      h = YAML.load_file(file)
      univ_name = h.keys.first

      if looks_like_we_have_created_organisations?(univ_name)
        puts "#{univ_name} found in db, assuming these organizations exist. Aborting."
      else
        root = create!(nil, name: univ_name, key: get_key(file))
        create_organizations(h.fetch(univ_name), root)
      end
    end

    def get_key(file)
      File.basename(file).sub(/\..+/, '').tap do |k|
        puts "Extracted key #{k} from filename"
      end
    end

    def looks_like_we_have_created_organisations?(univ_name)
      Organization.find_by(name: univ_name) rescue false
    end

    def create_organizations(organizations, parent=nil)
      organizations.each do |org|
        if org.kind_of?(String)
          create!(parent, name: org)
        elsif structured_list?(org)
          head, *tail = org
          create_organizations(tail, create!(parent, name: head))
        else
          create_organizations(org, parent)
        end
      end
    end

    def structured_list?(l)
      l.size == 2 && l.last.respond_to?(:each)
    end

    def create!(parent, h)
      puts "Creating #{parent.try(:name) || 'root'} / #{h[:name]}"
      Organization.create!(h.merge(parent: parent))
    end
  end
end
