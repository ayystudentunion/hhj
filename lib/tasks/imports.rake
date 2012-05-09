namespace :db do
  namespace :import do

    desc "import Helsinki University organization chart from YAML file"
    task :hu_org_chart => :environment do
      org_fpath = File.join(Rails.root, 'resources', 'hu_organisaatiokaavio.yml')
      h = YAML.load_file(org_fpath)

      if looks_like_we_have_already_imported_organizations?
        univ_name = 'Helsingin yliopisto'
        root = create!(nil, name: univ_name, key: 'hy')
        create_organizations(h.fetch(univ_name), root)
      end
    end

    def looks_like_we_have_already_imported_organizations?
      threshold = 100
      db_count = Organization.count

      if db_count >= threshold
        puts "looks like we already have organizations in place (found #{db_count} in db)"
        false
      else
        true
      end
    end

    def create_organizations(organizations, parent=nil)
      organizations.each do |org|
        case org
        when String
          create!(parent, name: org)
        when Array
          if structured_list?(org)
            head, *tail = org
            create_organizations(tail, create!(parent, name: head))
          else
            create_organizations(org, parent)
          end
        when Hash
          create_organizations(org, parent)
        else
          raise "unexpected entry #{org.inspect}"
        end
      end
    end

    def structured_list?(l)
      l.size == 2 && l.last.respond_to?(:each)
    end

    def create!(parent, h)
      #parent_name = parent ? parent[:name] : '(nil)'
      #name = h[:name]
      #puts "  #{parent_name} / #{name}"
      Organization.create!(h.except(:children).merge(parent: parent))
    end
  end
end