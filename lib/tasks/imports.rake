namespace :db do
  namespace :import do

    desc "import Helsinki University organization chart from YAML file"
    task :org_chart => :environment do
      fpath = ENV['fpath']
      raise "Pass env var fpath to task with full pathname to yml file (look under resources/ for files)" unless fpath

      h = YAML.load_file(fpath)
      univ_name = h.keys.first

      if looks_like_we_have_created_organisations?(univ_name)
        puts "#{univ_name} found in db, assuming these organizations exist. Aborting."
      else
        root = create!(nil, name: univ_name, key: get_key(fpath))
        create_organizations(h.fetch(univ_name), root)
      end
    end

    def get_key(fpath)
      File.basename(fpath).sub(/\..+/, '').tap do |k|
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
